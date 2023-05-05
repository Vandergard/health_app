import $ from "jquery";

$(document).ready(function () {
    $("#exercise-search").on("input", function () {
        let query = $(this).val();
        if (query.length === 0) {
            clearSearchResults();
            return;
        }
        if (query.length >= 3) {
            $.ajax({
                url: "/exercises/search",
                method: "GET",
                data: { query: query, format: 'json' }, 
                dataType: "json",
                success: function (data) {
                    // Обработка и отображение результатов поиска
                    displaySearchResults(data); // добавлено здесь
                }
            });
        }
    });

    function displaySearchResults(results) {
        const resultsContainer = $("#search-results");
        resultsContainer.empty(); // Очистите контейнер перед добавлением новых результатов

        if (results.length === 0) {
            resultsContainer.append("<p>Нет результатов поиска</p>");
            return;
        }

        const resultList = $("<div class='dropdown-menu show'></div>");
    results.forEach((result) => {
        resultList.append(`<div class='dropdown-item'>${result.name}</div>`); // Замените `result.name` на актуальное свойство объекта, если имя упражнения хранится в другом поле
    });

        resultsContainer.append(resultList);
    }

    function clearSearchResults() {
        const resultsContainer = $("#search-results");
        resultsContainer.empty();
    }
});
