/**
 * ============================================
 * ADMIN DASHBOARD - JAVASCRIPT
 * Hệ Thống Thiện Nguyện Việt
 * ============================================
 */

// ============== CHART.JS - BIỂU ĐỒ QUYÊN GÓP THEO THÁNG ==============

let chartQuyenGopInstance = null;

/**
 * Khởi tạo biểu đồ Chart.js
 */
function initChartQuyenGop() {
    const ctx = document.getElementById('chartQuyenGop');
    if (!ctx) return;

    const chartCanvas = ctx.getContext('2d');

    chartQuyenGopInstance = new Chart(chartCanvas, {
        type: 'line',
        data: {
            labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
            datasets: [
                {
                    label: 'Số tiền quyên góp (triệu đ)',
                    data: [120, 185, 320, 250, 190, 280, 340, 410, 290, 360, 275, 420],
                    borderColor: '#3182CE',
                    backgroundColor: 'rgba(49, 130, 206, 0.1)',
                    borderWidth: 2.5,
                    fill: true,
                    tension: 0.4,
                    pointRadius: 5,
                    pointBackgroundColor: '#3182CE',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointHoverRadius: 7,
                    pointHoverBackgroundColor: '#2B6CB0',
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: true,
                    position: 'top',
                    labels: {
                        font: {
                            family: "'Be Vietnam Pro', sans-serif",
                            size: 12,
                            weight: '500'
                        },
                        color: '#2D3748',
                        padding: 16,
                        usePointStyle: true,
                        pointStyle: 'circle'
                    }
                },
                tooltip: {
                    backgroundColor: 'rgba(45, 55, 72, 0.95)',
                    padding: 12,
                    titleFont: {
                        family: "'Be Vietnam Pro', sans-serif",
                        size: 13,
                        weight: '600'
                    },
                    bodyFont: {
                        family: "'Be Vietnam Pro', sans-serif",
                        size: 12
                    },
                    borderColor: 'rgba(255, 255, 255, 0.2)',
                    borderWidth: 1,
                    cornerRadius: 6,
                    displayColors: false,
                    callbacks: {
                        label: function (context) {
                            return context.parsed.y + ' triệu đ';
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 500,
                    ticks: {
                        stepSize: 100,
                        color: '#718096',
                        font: {
                            family: "'Be Vietnam Pro', sans-serif",
                            size: 12
                        },
                        callback: function (value) {
                            return value + 'M';
                        }
                    },
                    grid: {
                        color: 'rgba(226, 232, 240, 0.5)',
                        drawBorder: false,
                        tickBorderDash: [4, 4]
                    }
                },
                x: {
                    ticks: {
                        color: '#718096',
                        font: {
                            family: "'Be Vietnam Pro', sans-serif",
                            size: 12,
                            weight: '500'
                        }
                    },
                    grid: {
                        display: false,
                        drawBorder: false
                    }
                }
            }
        }
    });
}

/**
 * Cập nhật dữ liệu biểu đồ
 * @param {object} data - { labels: [...], values: [...] }
 */
function updateChartData(data) {
    if (!chartQuyenGopInstance) return;

    if (data.labels) {
        chartQuyenGopInstance.data.labels = data.labels;
    }

    if (data.values) {
        chartQuyenGopInstance.data.datasets[0].data = data.values;
    }

    chartQuyenGopInstance.update();
}

// ============== STAT CARDS - CẬP NHẬT DỮ LIỆU ==============

/**
 * Cập nhật dữ liệu 4 Stat Cards
 * @param {object} data - { 
 *     chiendichDangChay: 5, 
 *     choXuLy: 3, 
 *     tongTienQuyen: 2300, 
 *     nguoiDung: 1200 
 * }
 */
function updateStatCards(data) {
    // Cập nhật Chiến dịch đang chạy
    const statChienDich = document.getElementById('stat-chiendich');
    if (statChienDich && data.chiendichDangChay !== undefined) {
        statChienDich.textContent = data.chiendichDangChay;
    }

    // Cập nhật Chờ xét duyệt
    const statChoXuLy = document.getElementById('stat-choxuly');
    if (statChoXuLy && data.choXuLy !== undefined) {
        statChoXuLy.textContent = data.choXuLy;
    }

    // Cập nhật Tổng tiền quyên góp
    const statTongQuyen = document.getElementById('stat-tongquyen');
    if (statTongQuyen && data.tongTienQuyen !== undefined) {
        const tienTySo = (data.tongTienQuyen / 1000000000).toFixed(1);
        statTongQuyen.textContent = tienTySo + ' Tỷ';
    }

    // Cập nhật Người dùng
    const statNguoiDung = document.getElementById('stat-nguoidung');
    if (statNguoiDung && data.nguoiDung !== undefined) {
        const nguoiDungK = (data.nguoiDung / 1000).toFixed(1);
        statNguoiDung.textContent = nguoiDungK + 'K';
    }
}

// ============== BẢNG GIAO DỊCH - CẬP NHẬT DỮ LIỆU ==============

/**
 * Cập nhật bảng giao dịch gần đây
 * @param {array} data - [
 *     { nguoiQuy: "Tên", chiendich: "Tên CD", sotien: 500000, trangthai: "Đã duyệt" },
 *     ...
 * ]
 */
function updateTableGiaoDich(data) {
    const tbody = document.querySelector('.admin-table tbody');
    if (!tbody || !data || data.length === 0) return;

    tbody.innerHTML = '';

    data.forEach(row => {
        const tr = document.createElement('tr');

        // Xác định badge trạng thái
        let badgeClass = 'badge-thanh-cong';
        let badgeText = 'Đã duyệt';

        if (row.trangthai === 'Chờ duyệt') {
            badgeClass = 'badge-cho-duyet';
            badgeText = 'Chờ duyệt';
        } else if (row.trangthai === 'Từ chối') {
            badgeClass = 'badge-tu-choi';
            badgeText = 'Từ chối';
        } else if (row.trangthai === 'Tạm dừng') {
            badgeClass = 'badge-tam-dung';
            badgeText = 'Tạm dừng';
        }

        const soTienFormatted = row.sotien.toLocaleString('vi-VN');

        tr.innerHTML = `
            <td>${row.nguoiQuy}</td>
            <td>${row.chiendich}</td>
            <td>${soTienFormatted}đ</td>
            <td><span class="badge-admin ${badgeClass}">${badgeText}</span></td>
        `;

        tbody.appendChild(tr);
    });
}

// ============== HELPER FUNCTIONS ==============

/**
 * Format tiền tệ VND
 * @param {number} value 
 * @returns {string}
 */
function formatCurrency(value) {
    return value.toLocaleString('vi-VN') + ' đ';
}

/**
 * Format số với K, M, Tr, Tỷ
 * @param {number} num 
 * @returns {string}
 */
function formatNumber(num) {
    if (num >= 1000000000) {
        return (num / 1000000000).toFixed(1) + ' Tỷ';
    } else if (num >= 1000000) {
        return (num / 1000000).toFixed(1) + ' Tr';
    } else if (num >= 1000) {
        return (num / 1000).toFixed(1) + ' K';
    }
    return num.toString();
}

/**
 * Show loading spinner
 */
function showLoading() {
    const loader = document.getElementById('loader');
    if (loader) loader.style.display = 'flex';
}

/**
 * Hide loading spinner
 */
function hideLoading() {
    const loader = document.getElementById('loader');
    if (loader) loader.style.display = 'none';
}

/**
 * Show error notification
 * @param {string} message 
 */
function showError(message) {
    const errorDiv = document.getElementById('error-notification');
    if (errorDiv) {
        errorDiv.textContent = message;
        errorDiv.style.display = 'block';

        // Auto hide sau 5 giây
        setTimeout(() => {
            errorDiv.style.display = 'none';
        }, 5000);
    }
}

// ============== INITIALIZATION ==============

/**
 * Khởi tạo dashboard khi DOM load
 */
document.addEventListener('DOMContentLoaded', function () {
    // Khởi tạo Chart.js
    initChartQuyenGop();

    // Thêm event listeners nếu cần
    // ...
});

// ============== EXPORT FUNCTIONS ==============

if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        initChartQuyenGop,
        updateChartData,
        updateStatCards,
        updateTableGiaoDich,
        formatCurrency,
        formatNumber,
        showLoading,
        hideLoading,
        showError
    };
}
