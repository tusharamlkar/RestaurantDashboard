new Chart(document.getElementById('barChart'), {
    type: 'bar',
    data: {
        labels: resLabels,
        datasets: [{
            label: 'Reservations',
            data: resData,
            backgroundColor: '#4caf50'
        }]
    }
});

new Chart(document.getElementById('lineChart'), {
    type: 'line',
    data: {
        labels: revLabels,
        datasets: [{
            label: 'Revenue',
            data: revData,
            borderColor: '#6c5ce7',
            fill: false
        }]
    }
});
const resCtx = document.getElementById('resChart').getContext('2d');

new Chart(resCtx, {
    type: 'line',
    data: {
        labels: resLabels,
        datasets: [{
            label: 'Reservations',
            data: resData
        }]
    }
});