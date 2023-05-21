$(document).ready(function() {
    // Получение данных тренировки и упражнений из базы данных
    $.ajax({
      url: "/trainings",
      data: { training: trainingId }, // Замените <training_id> на фактический идентификатор тренировки
      method: "GET",
      dataType: "json",
      success: function(data) {
        // Отображение информации о тренировке
        $("#training-name").text(data.name);
        $("#training-category").text(data.category);
        $("#training-difficulty").text(data.difficulty);
        $("#training-desc").text(data.description);
  
        // Отображение информации об упражнениях
        data.training_sets.forEach(function(trainingSet) {
          const exerciseName = trainingSet.name;
          const reps = trainingSet.reps;
          const duration = trainingSet.duration;
          const setRest = trainingSet.set_rest;
  
          const exerciseRow = `
            <tr>
              <td>${exerciseName}</td>
              <td>${reps}</td>
              <td>${duration}</td>
              <td>${setRest}</td>
            </tr>
          `;
          $("#exercise-table tbody").append(exerciseRow);
        });
      },
      error: function(response) {
        // Обработка ошибки
        console.error(response);
      }
    });
  });