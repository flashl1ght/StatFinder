// Prevent accidental window closing
window.addEventListener('beforeunload', function (e) {
    e.preventDefault();
    e.returnValue = '';
});