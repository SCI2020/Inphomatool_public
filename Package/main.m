close all
clear all

addpath(genpath(pwd));

pa = Page;
pa_0 = MainPageUI;
pa_1 = CalibrationPageUI;
pa_2 = MannualPageUI;
pa_3 = AutoPageUI;
pa_4 = EnhancePageUI;
pa_5 = ReconstructionPageUI;
pa_6 = GlobalParamsUI;

pa.Page_home = pa_0;
pa.Page_cali = pa_1;
pa.Page_mannual = pa_2;
pa.Page_auto = pa_3;
pa.Page_enhance = pa_4;
pa.Page_recon = pa_5;
pa.Page_params = pa_6;

pa_0.page = pa;
pa_1.page = pa;
pa_2.page = pa;
pa_3.page = pa;
pa_4.page = pa;
pa_5.page = pa;
pa_6.page = pa;

pa_1.UIFigure.Visible = 'off';
pa_2.UIFigure.Visible = 'off';
pa_3.UIFigure.Visible = 'off';
pa_4.UIFigure.Visible = 'off';
pa_5.UIFigure.Visible = 'off';
pa_6.UIFigure.Visible = 'off';