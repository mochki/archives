// Checks to see if two arrays are identical
export default function arraysEqual(arr1, arr2) {
  if (arr1.length !== arr2.length) return false;

  for (let i = arr1.length; i--; ) {
    if (arr1[i] !== arr2[i]) return false;
  }

  return true;
}
