/**
 * Simple client‑side include utility.
 * Place a <div data-include="path/to/file.html"></div>
 * wherever you want a fragment inserted.
 */
document.addEventListener('DOMContentLoaded', () => {
  const includes = document.querySelectorAll('[data-include]');
  includes.forEach(el => {
    const url = el.getAttribute('data-include');
    fetch(url)
      .then(resp => {
        if (!resp.ok) throw new Error(`HTTP ${resp.status}`);
        return resp.text();
      })
      .then(html => {
        el.innerHTML = html;
      })
      .catch(err => {
        console.error(`Failed to load ${url}:`, err);
        el.innerHTML = '<!-- include error -->';
      });
  });
});