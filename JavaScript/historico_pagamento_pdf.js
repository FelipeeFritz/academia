function generatePDF() {
    var element = document.body; 
    html2canvas(element).then(function(canvas) {
        var imgData = canvas.toDataURL('image/png');
        var doc = new jsPDF('p', 'mm', 'a4');
        var imgHeight = canvas.height * 210 / canvas.width;
        doc.addImage(imgData, 0, 0, 210, imgHeight);
        doc.save('historico_pagamento.pdf');
    });
}