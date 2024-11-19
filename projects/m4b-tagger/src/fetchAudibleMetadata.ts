import { promises as fs } from 'fs';
import { chromium } from 'playwright';
import { config } from 'dotenv';
import fetch from 'node-fetch';
config();

type ldJSON = {
  '@type': string;
  author: { name: string }[];
  datePublished: string;
  description: string;
  image: string;
  name: string;
  readBy: { name: string }[];
};

(async () => {
  const rootPath = process.env.BOOKS_DIRECTORY!;
  const bookFolders = (await fs.readdir(rootPath)).filter(filename => filename !== '.DS_Store');

  const browser = await chromium.launch({ headless: false });
  const page = await browser.newPage();

  await page.goto('https://www.audible.com/');
  await page.click('.ui-it-sign-in-link');

  // Sign in
  await page.type('input[type=email]', process.env.AUDIBLE_EMAIL!);
  await page.type('input[type=password]', process.env.AUDIBLE_PASSWORD!);
  await page.click('#signInSubmit');

  // May need to manually verify login
  await page.waitForSelector('input[type=search]');

  // Now we begin the data mining
  for (const book of bookFolders) {
    console.log(`Fetching data for: ${book}`)
    await page.goto('https://www.audible.com/');
    await page.type('input[type=search]', book);
    await page.press('input[type=search]', 'Enter');

    await page.click('.productListItem .bc-link'); // First element
    await page.waitForLoadState('load');

    // Grabbing data Audiobook meta data & audcover
    const scriptCandidates = await page.$$('script[type="application/ld+json"]');
    const scriptJSONs = (
      await Promise.all(scriptCandidates.map(async scriptEl => JSON.parse(await scriptEl.innerHTML()) as ldJSON))
    ).flat();
    const rawAudiobookData = scriptJSONs.filter(jsonData => jsonData['@type'] === 'Audiobook')[0];

    const audiobookResourceID = await page.evaluate(() => {
      const path = document.location.pathname.split('/');
      return path[path.length - 1];
    });

    // Now to fetch the chapters
    const [playerMetadataResponse] = await Promise.all([
      page.waitForResponse(/licenserequest/),
      page.goto(`https://www.audible.com/webplayer?asin=${audiobookResourceID}`),
    ]);

    const playerMetadata = JSON.parse(await playerMetadataResponse.text());

    const audiobookData = {
      name: rawAudiobookData.name,
      author: rawAudiobookData.author.map(({ name }) => name).join(', '),
      narrator: rawAudiobookData.readBy.map(({ name }) => name).join(', '),
      year: new Date(rawAudiobookData.datePublished).getFullYear(),
      description: rawAudiobookData.description
        .split('<p>')
        .map(line => line.replace('</p>', '').replaceAll('<i>', '').replaceAll('</i>', '').trim())
        .join('\n'),
      chapterInfo: playerMetadata.content_license.content_metadata.chapter_info,
    };

    const imageBuffer = await (await fetch(rawAudiobookData.image)).buffer();

    await fs.writeFile(`${process.env.BOOKS_DIRECTORY}/${book}/cover.jpg`, imageBuffer);
    await fs.writeFile(`${process.env.BOOKS_DIRECTORY}/${book}/metadata.json`, JSON.stringify(audiobookData));
  }

  await browser.close();
})();
