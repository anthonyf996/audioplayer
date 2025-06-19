const listItemsArr = document.querySelectorAll('.song-list-item');
const songSearch = document.querySelector('#song-search');
let highlightedItem = null;
let audio = null;

songSearch.addEventListener('input', function() {
	const inputText = this.value;
	listItemsArr.forEach(function (listItem) {
		const title = listItem.getAttribute('data-title');
		if (!title.toLowerCase().includes(inputText.toLowerCase())) {
			listItem.setAttribute('data-hidden', 'true');
		} else {
			listItem.removeAttribute('data-hidden');
		}
	});
});

listItemsArr.forEach(function (listItem) {
	listItem.addEventListener('click', function() {
		if (highlightedItem) {
			if (highlightedItem == this && highlightedItem.getAttribute('data-selected') == 'true') {
				audio.pause();
				highlightedItem.removeAttribute('data-selected');
			} else {
				audio.pause();
				highlightedItem.removeAttribute('data-selected');
				this.setAttribute('data-selected', 'true');
				highlightedItem = this;
				const songPath = this.getAttribute('data-song-path');
				audio = new Audio(songPath);
				audio.addEventListener('ended', function () {
					highlightedItem.removeAttribute('data-selected');
				});
				audio.play();
			}
		} else {
			this.setAttribute('data-selected', 'true');
			highlightedItem = this;
			const songPath = this.getAttribute('data-song-path');
			audio = new Audio(songPath);
			audio.addEventListener('ended', function () {
				highlightedItem.removeAttribute('data-selected');
			});
			audio.play();
		}
	});
});
