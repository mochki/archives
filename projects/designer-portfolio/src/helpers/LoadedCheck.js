// Check if all images on a page have loaded

export function ImagesFin () {
  for (const img of document.querySelectorAll('img')) {
    if (!img.complete) return false;
  }
  return true;
}