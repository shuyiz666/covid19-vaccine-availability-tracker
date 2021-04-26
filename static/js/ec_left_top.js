var ec_left_top = echarts.init(document.getElementById('lt'), "dark");

var ec_left_top_option = {
       title: {
        text: 'The Number of Stores Nearby',
        subtext: 'Star Market vs. Shaws',
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
            name: 'the Store nearby',
            type: 'pie',
            radius: '50%',
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
ec_left_top.setOption(ec_left_top_option)
