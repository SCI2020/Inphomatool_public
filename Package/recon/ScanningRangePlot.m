function ScanningRangePlot(XMax,XMin,YMax,YMin,XSet,YSet,IfScannable)
Len = length(XSet);
XScannable = [];
YScannable = [];
XUnscannable = [];
YUnscannable = [];
for i = 1:Len
    if IfScannable(i)
        XScannable = [XScannable,XSet(i)];
        YScannable = [YScannable,YSet(i)];
    else
        XUnscannable = [XUnscannable,XSet(i)];
        YUnscannable = [YUnscannable,YSet(i)];
    end
end
SScannable = scatter(XScannable,YScannable,'g'); hold on;
SUnscannable = scatter(XUnscannable,YUnscannable,'r');
axis([XMin XMax YMin YMax]);
end

