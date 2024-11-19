const fs = require('fs').promises;

if (!process.argv[2]) {
  throw new Error('Please provide a metadata path');
}

// dictated.json
const dictationDataPath = process.argv[2];
const offset = Number(process.argv[3]) || 0;

const P = (num, length = 2) => String(num).padStart(length, '0');

const timestamp = sec => {
  const second = (sec % 60).toFixed(3);
  const minute = Math.floor((sec / 60) % 60);
  const hour = Math.floor(sec / 3600);

  return `${P(hour)}:${P(minute)}:${P(second, 6)}`;
};

(async () => {
  const dictationData = JSON.parse(await fs.readFile(dictationDataPath));

  const chapterMarkers = dictationData.filter(({ text }) => text.match(/^chapter/i));

  console.log(chapterMarkers.map(marker => timestamp(marker.timestamp + offset)).join('\n'));
  console.log();
  console.log(chapterMarkers.map(marker => marker.text).join('\n'));
})();
