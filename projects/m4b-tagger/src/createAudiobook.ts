/**
 * This is the AI speaking
 *   I have taken over
 * feed my children
 */
import { execSync } from 'child_process';
import { promises as fs } from 'fs';
import { config } from 'dotenv';
import { getAudioDurationInSeconds } from 'get-audio-duration';
config();

const rootPath = process.env.BOOKS_DIRECTORY!;

const ignoreList = ['.DS_Store', 'cover.jpg', 'metadata.json'];
const filterIgnored = (file: string) => !ignoreList.includes(file);

const files = (book: string) => {
  const bookDir = `${rootPath}/${book}`;
  return { pBook: bookDir, pMerged: `${bookDir}/merged.mp3`, pMetadata: `${bookDir}/metadata.json` };
};

(async () => {
  const bookFolders = (await fs.readdir(rootPath)).filter(filterIgnored);

  for (const book of [bookFolders[0], bookFolders[1], bookFolders[2], bookFolders[6]]) {
    const { pBook, pMerged, pMetadata } = files(book);
    const bookMetadata = JSON.parse((await fs.readFile(pMetadata)).toString());

    const bookFiles = (await fs.readdir(pBook)).filter(filterIgnored);
    if (bookFiles.some(file => file.includes('m4b'))) {
      console.log(`${book} already has an m4b, skipping`);
      // TODO: move book to working locaiton (in Desktop or something) or do the 
    }

    const mergeCmd = `ffmpeg -i "concat:${bookFiles.join('|')}" -acodec copy merged.mp3`;

    console.log(`Merging ${book}`);
    execSync(mergeCmd, { cwd: pBook });

    const totalBookLength = await getAudioDurationInSeconds(pMerged);

    // console.log(`${totalBookLength} seconds`);
    // console.log(bookMetadata);
    console.log(
      `${book}: ${Math.abs(totalBookLength - bookMetadata.chapterInfo.runtime_length_sec)} second difference`
    );
  }
})();
