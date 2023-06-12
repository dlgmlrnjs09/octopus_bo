/* Info
   ========================================================================== */
/**
 * 1. Writer: Hyerin Lim. (Weaverloft Corp.)
 * 2. Production Date: 2023-06-08
 * 3. Client: Weaverloft UX
 */

/*========== Basic ==========*/

/*========== Admin ==========*/
$(function () {
    if ($(".admin .main-chart-sec").length > 0) {
        var options = {
            lang: {
                noData: '데이터가 없습니다',
            },
            chart: {
                width: 758,
                height: 380,
                // width: 'auto',
                // height: 'auto',
                animation: {
                    duration: 600
                }
            },
            // responsive: {
            //     animation: {
            //         duration: 300
            //     },
            //     rules: [{
            //             condition: ({
            //                 width: w
            //             }) => {
            //                 return w <= 800;
            //             },
            //             options: {
            //                 legend: {
            //                     align: 'right'
            //                 }
            //             }
            //         },
            //         {
            //             condition: ({
            //                 width: w
            //             }) => {
            //                 return w <= 600;
            //             },
            //             options: {
            //                 xAxis: {
            //                     tick: {
            //                         interval: 6
            //                     },
            //                     label: {
            //                         interval: 6
            //                     }
            //                 }
            //             }
            //         },
            //         {
            //             condition: ({
            //                 width: w,
            //                 height: h
            //             }) => {
            //                 return w <= 500 && h <= 400;
            //             },
            //             options: {
            //                 chart: {
            //                     title: ''
            //                 },
            //                 legend: {
            //                     visible: false
            //                 },
            //                 exportMenu: {
            //                     visible: false
            //                 }
            //             }
            //         }
            //     ]
            // },
            series: {
                stack: {
                    type: 'normal',
                },
            },
            exportMenu: {
                visible: false
            },
            legend: {
                visible: true,
                showCheckbox: false,
            },
            theme: {
                series: {
                    barWidth: 40,
                    barThickness: 30,
                    borderRadius: 4,
                    colors: ['#A699F8', '#5A78EE', '#B8B8D4', '#E1E1EC'],
                },
                legend: {
                    label: {
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        color: '#999',
                    },
                },
                chart: {
                    backgroundColor: 'transparent',
                },
                yAxis: {
                    label: {
                        fontSize: 0,
                    },
                    color: 'transparent',
                },
                xAxis: {
                    label: {
                        fontFamily: 'Pretendard',
                        fontSize: 14,
                        fontWeight: 500,
                        color: '#555',
                    },
                    color: '#fff',
                },
                plot: {
                    vertical: {
                        lineColor: 'transparent',
                    },
                    horizontal: {
                        lineColor: 'transparent',
                    },
                },
            },
        };
        function chartSalesTable01(){
            const el = document.getElementById('chart-sales-table01');
            const data = {
                categories: ['6월', '5월', '4월', '3월', '2월', '1월'],
                series: [{
                        name: '신규주문',
                        data: [160, 160, 84, 70, 158, 78],
                    },
                    {
                        name: '재주문',
                        data: [33, 63, 160, 88, 33, 80],
                    },
                    {
                        name: '반품 · 교환',
                        data: [97, 33, 33, 40, 47, 96],
                    },
                    {
                        name: '취소',
                        data: [160, 0, 97, 0, 16, 19],
                    },
                ],
            };
            options

            const chart = toastui.Chart.columnChart({ el, data, options });
            chart.hideSeriesDataLabel();
        } chartSalesTable01();
        
        function chartOrderTable01(){
            const el = document.getElementById('chart-order-table01');
            const data = {
                categories: ['6월', '5월', '4월', '3월', '2월', '1월'],
                series: [{
                        name: '신규주문',
                        data: [61, 160, 84, 70, 158, 78],
                    },
                    {
                        name: '재주문',
                        data: [33, 63, 9, 88, 33, 80],
                    },
                    {
                        name: '반품 · 교환',
                        data: [97, 33, 33, 40, 47, 96],
                    },
                    {
                        name: '취소',
                        data: [32, 0, 97, 0, 16, 19],
                    },
                ],
            };
            options

            const chart = toastui.Chart.columnChart({ el, data, options });
            chart.hideSeriesDataLabel();
        } chartOrderTable01();
        
        function chartMemberTable01(){
            const el = document.getElementById('chart-member-table01');
            const data = {
                categories: ['6월', '5월', '4월', '3월', '2월', '1월'],
                series: [{
                        name: '신규주문',
                        data: [1, 23, 84, 64, 158, 78],
                    },
                    {
                        name: '재주문',
                        data: [33, 63, 90, 88, 33, 80],
                    },
                    {
                        name: '반품 · 교환',
                        data: [97, 33, 13, 40, 47, 96],
                    },
                    {
                        name: '취소',
                        data: [32, 0, 22, 0, 16, 19],
                    },
                ],
            };
            options

            const chart = toastui.Chart.columnChart({ el, data, options });
            chart.hideSeriesDataLabel();
        } chartMemberTable01();
        
        function chartVisitTable01(){
            const el = document.getElementById('chart-visit-table01');
            const data = {
                categories: ['6월', '5월', '4월', '3월', '2월', '1월'],
                series: [{
                        name: '신규주문',
                        data: [100, 23, 84, 64, 18, 78],
                    },
                    {
                        name: '재주문',
                        data: [33, 63, 90, 58, 33, 80],
                    },
                    {
                        name: '반품 · 교환',
                        data: [97, 33, 65, 40, 47, 96],
                    },
                    {
                        name: '취소',
                        data: [32, 0, 22, 0, 16, 44],
                    },
                ],
            };
            options

            const chart = toastui.Chart.columnChart({ el, data, options });
            chart.hideSeriesDataLabel();
        } chartVisitTable01();
    }
})
