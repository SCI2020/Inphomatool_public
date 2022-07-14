classdef Page < handle
    properties
        Page_home
        Page_cali
        Page_auto
        Page_mannual
        Page_enhance
        Page_recon
        Page_params
        pres
        next
    end
    
    
    methods
        function Switch_Page(page)
            page.pres.UIFigure.Visible = 'off';
            page.next.UIFigure.Visible = 'on';
        end
    end
end