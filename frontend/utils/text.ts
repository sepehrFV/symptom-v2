/**
 * Truncates text to a specified maximum length and adds ellipsis if needed
 * @param text - The text to truncate
 * @param maxLength - Maximum length before truncation (default: 100)
 * @returns Truncated text with ellipsis if it exceeds maxLength
 */
export const truncateText = (text: string, maxLength: number = 100): string => {
  if (text.length <= maxLength) return text;
  return text.substring(0, maxLength) + '...';
};

/**
 * Capitalizes the first letter of a string and lowercases the rest
 * @param text - The text to capitalize
 * @returns Text with first letter capitalized and rest lowercased
 */
export const capitalizeText = (text: string): string => {
  if (!text) return text;
  return text.charAt(0).toUpperCase() + text.slice(1).toLowerCase();
};
