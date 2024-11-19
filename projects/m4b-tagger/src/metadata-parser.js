const fs = require('fs').promises;

if (!process.argv[2]) {
  throw new Error('Please provide a metadata path');
}

const metadataPath = process.argv[2];

const P = num => String(num).padStart(2, '0');

const timestamp = sec => {
  const second = sec % 60;
  const minute = Math.floor((sec / 60) % 60);
  const hour = Math.floor(sec / 3600);

  return `${P(hour)}:${P(minute)}:${P(second)}`;
};

const chapterReducer = key => (accum, curr) => {
  if (curr.chapters) {
    accum.push(...curr.chapters.map(chapter => chapter[key]));
  } else {
    accum.push(curr[key]);
  }
  return accum;
};

const timestampReducer = chapterReducer('start_offset_sec');
const titleReducer = chapterReducer('title');

(async () => {
  const {
    chapterInfo: { chapters, runtime_length_sec },
  } = JSON.parse(await fs.readFile(metadataPath));

  console.log(`Running Length: ${timestamp(runtime_length_sec)}\n`);

  const timestamps = chapters.reduce(timestampReducer, []).map(timestamp);
  const titles = chapters.reduce(titleReducer, []);

  console.log(timestamps.map((timestamp, i) => ({ timestamp, title: titles[i] })));

  // console.log(chapters.reduce(timestampReducer, []).map(timestamp).join('\n'));
  // console.log();
  // console.log(chapters.reduce(titleReducer, []).join('\n'));
})();
