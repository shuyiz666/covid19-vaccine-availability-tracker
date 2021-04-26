var ec_left_bottom = echarts.init(document.getElementById('lb'), "dark");

var ec_left_bottom_option = {
       title: {
        text: 'The Vaccine Availability Nearby',
        subtext: 'availability occupation for each type of store',
        left: 'center'
    },
    tooltip: {
        trigger: 'item'
    },
    legend: {
        orient: 'vertical',
        left: 'left',
    },
    series: [
        {
            name: 'the star market nearby',
            type: 'pie',
            radius: '50%',
            center: ['25%', '50%'],
            data: [],
            emphasis: {
                itemStyle: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        },
        {
            name: 'the shaws nearby',
            type: 'pie',
            radius: '50%',
            center: ['75%', '50%'],
            data: [],
            emphasis: {
                itemStyle: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }
    ]
};

ec_left_bottom.setOption(ec_left_bottom_option)
