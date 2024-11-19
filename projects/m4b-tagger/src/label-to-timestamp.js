const fs = require("fs").promises;

if (!process.argv[2]) {
  throw new Error('Please provide a metadata path');
}

const labelTrackPath = process.argv[2];

const P = (num, length = 2) => String(num).padStart(length, "0");

const timestamp = (sec) => {
  const second = (sec % 60).toFixed(3);
  const minute = Math.floor((sec / 60) % 60);
  const hour = Math.floor(sec / 3600);

  return `${P(hour)}:${P(minute)}:${P(second, 6)}`;
};

(async () => {
  const rawLabels = '00:00:00.000' + (await fs.readFile(labelTrackPath)).toString();

  console.log(
    rawLabels
      .split("\n")
      .filter((I) => I)
      .map((rawStr) => rawStr.match(/(\d+\.\d+)/)[0])
      .map(timestamp)
      .join("\n")
  );
})();
