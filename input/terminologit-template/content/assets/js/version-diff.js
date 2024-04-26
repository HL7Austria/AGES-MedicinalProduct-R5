/**
 * Escapes characters that must not be part of an URL if used as parameter.
 *
 * @param {*} unsafe
 * @returns the escaped string
 */
function escapeHtml(unsafe) {
  return unsafe
       .replace(/\//g, "%2F")
       .replace(/:/g, "%3A");
}

/**
 * Uses https://services.w3.org/htmldiff in order to provide a comparison
 * between the current and the outdated version of a html page.
 *
 * @param {*} current
 * @param {*} outdated
 */
function createDiff(current, outdated) {
  // retrieve the current page's URL
  var href = window.location.href;
  // strip everything from the href after the last occurrence of '/'
  var baseURL = href.substring(0, href.lastIndexOf('/')+1);
  // create the URLs for the current and outdated html page
  var currentURL = baseURL.concat(current);
  var outdatedURL = baseURL.concat(outdated);
  // escape unsafe characters
  currentURL = escapeHtml(currentURL);
  outdatedURL = escapeHtml(outdatedURL);

  // open the comparison
  window.open('https://services.w3.org/htmldiff?doc1='.concat(outdatedURL).concat('&doc2=').concat(currentURL));
}
