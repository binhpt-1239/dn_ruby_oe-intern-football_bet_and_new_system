win = $('.chart').data('win')
lose = $('.chart').data('lose')

var xValues = ["Win", "Lose"];
var yValues = [win, lose];
var barColors = [
  "#b91d47",
  "#00aba9",
];

new Chart("myChart", {
  type: "pie",
  data: {
    labels: xValues,
    datasets: [{
      backgroundColor: barColors,
      data: yValues
    }]
  },
  options: {
    title: {
      display: true,
      text:"Earning statistics of all matches"
    }
  }
});
