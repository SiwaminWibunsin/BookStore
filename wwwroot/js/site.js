document.getElementById('search').addEventListener('click', searchBooks);

async function searchBooks() {
    try {
        const response = await fetch('/books');
        const books = await response.json();
        displayBooks(books);
        displaySummary(books);
    } catch (error) {
        console.error('Error fetching books:', error);
    }
}

function displayBooks(books) {
    const booksTable = document.getElementById('bookList').getElementsByTagName('tbody')[0];
    booksTable.innerHTML = ''; // Clear existing rows
    books.forEach(book => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${book.title}</td>
            <td>${book.author}</td>
            <td>${book.publication}</td>
            <td>${book.category.name}</td>
        `;
        booksTable.appendChild(row);
    });
}

function displaySummary(books) {
    const summaryDiv = document.createElement('div');
    const categories = {};
    books.forEach(book => {
        if (!categories[book.category.name]) {
            categories[book.category.name] = 0;
        }
        categories[book.category.name]++;
    });
    for (const [category, count] of Object.entries(categories)) {
        const p = document.createElement('p');
        p.textContent = `${category}: ${count} books`;
        summaryDiv.appendChild(p);
    }
    document.body.appendChild(summaryDiv);
}
