import $ from "jquery";
import "jquery-ui-dist/jquery-ui";
import '../stylesheets/jquery_ui.scss';

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


    $("#search-results").on("click", ".dropdown-item", function() {
        const exerciseId = $(this).data('id');
        const exerciseName = $(this).text();
        addExerciseToTable(exerciseName, exerciseId);
        clearSearchResults();
    });

    $("table").on("click", ".add-row", function () {
        const currentRow = $(this).closest("tr");
        const clonedRow = currentRow.clone(true);
        currentRow.after(clonedRow);
    });

    $("table").on("click", ".remove-row", function () {
        const currentRow = $(this).closest("tr");
        if ($("table tbody tr").length > 1) {
            currentRow.remove();
        } else {
            alert("Должна остаться хотя бы одна строка");
        }
    });

    $("#set-table tbody").sortable({
        items: "tr",
        cursor: "move",
        opacity: 0.6,
        update: function () {
          console.log("Порядок строк обновлен");
        },
        axis: "y", // Ограничьте перемещение элементов только по вертикальной оси
        helper: function(e, ui) {
            ui.children().each(function() {
                $(this).width($(this).width());
                $(this).height($(this).height());
              });
            return ui;
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
        resultList.append(`<div class='dropdown-item' data-id='${result.id}'>${result.name}</div>`); // Замените `result.name` на актуальное свойство объекта, если имя упражнения хранится в другом поле
    });

        resultsContainer.append(resultList);
    }

    function clearSearchResults() {
        const resultsContainer = $("#search-results");
        resultsContainer.empty();
    }

    function addExerciseToTable(exerciseName, exerciseId) {
        const newRow = `
            <tr>
                <td>${exerciseName}</td>
                <input type="hidden" name="exercise_id" value="${exerciseId}">
                <td><input type="number" class="form-control" min="1" step="1" name="reps"></td>
                <td><input type="number" class="form-control" min="1" step="1" name="duration"></td>
                <td><input type="number" class="form-control" min="1" step="1" name="sets_rest"></td>
                <td><input type="number" class="form-control" min="1" step="1" name="set_count"></td>
                <td><input type="text" class="form-control" name="set_config"></td>
                <td>
                    <button type="button" class="btn btn-danger remove-row">-</button>
                    <button type="button" class="btn btn-success add-row">+</button>
                </td>
            </tr>
        `;
        $("table tbody").append(newRow);
    }

    $("#create-training-form").submit(function(event) {
        alert("Form submitted");
        event.preventDefault();
    
        const trainingData = {
          name: $("#training-name").val(),
          category: $("#training-category").val(),
          difficulty: $("#training-difficulty").val(),
          description: $("#training-desc").val(),
          training_sets_attributes: [],
        };
    
        $("#set-table tbody tr").each(function() {
          const exerciseId = parseInt($(this).find("input[name='exercise_id']").val());
          const exerciseName = $(this).find("td:first-child").text();
          const reps = $(this).find("input[name='reps']").val();
          const duration = $(this).find("input[name='duration']").val();
          const sets_rest = $(this).find("input[name='set_rest']").val();
        //   const set_count = $(this).find("input[name='set_count']").val();
        //   const set_config = $(this).find("input[name='set_config']").val();
    
          trainingData.training_sets_attributes.push({
            exercise_id: exerciseId,
            reps,
            duration,
            sets_rest,
            // set_count,
            // set_config
          });
        });
    
        $.ajax({
          url: "/trainings", // замените на актуальный путь для создания тренировки
          method: "POST",
          data: { training: trainingData },
          dataType: "json",
          success: function(response) {
            // перенаправление или обработка ответа
            alert("Saved")
            console.log(response);
          },
          error: function(response) {
            // обработка ошибки
            alert("Error")
            console.error(response);
          }
        });
      });

});
