classdef scoreforecast_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure            matlab.ui.Figure
        Label_16            matlab.ui.control.Label
        EditField_18        matlab.ui.control.NumericEditField
        Label_15            matlab.ui.control.Label
        Label_14            matlab.ui.control.Label
        Label_13            matlab.ui.control.Label
        EditField_17        matlab.ui.control.NumericEditField
        Label_12            matlab.ui.control.Label
        BPLabel             matlab.ui.control.Label
        EditField_16        matlab.ui.control.NumericEditField
        Label_11            matlab.ui.control.Label
        Label_10            matlab.ui.control.Label
        Lamp                matlab.ui.control.Lamp
        EditField_15        matlab.ui.control.NumericEditField
        EditField_14        matlab.ui.control.NumericEditField
        Label_9             matlab.ui.control.Label
        EditField_13        matlab.ui.control.NumericEditField
        Label_8             matlab.ui.control.Label
        CET6EditField       matlab.ui.control.NumericEditField
        CET6EditFieldLabel  matlab.ui.control.Label
        CET4EditField       matlab.ui.control.NumericEditField
        CET4EditFieldLabel  matlab.ui.control.Label
        EditField_10        matlab.ui.control.NumericEditField
        Label_7             matlab.ui.control.Label
        EditField_9         matlab.ui.control.NumericEditField
        Label_6             matlab.ui.control.Label
        EditField_4         matlab.ui.control.NumericEditField
        Label_4             matlab.ui.control.Label
        EditField_3         matlab.ui.control.NumericEditField
        Label_3             matlab.ui.control.Label
        EditField_2         matlab.ui.control.NumericEditField
        Label_2             matlab.ui.control.Label
        PredictButton       matlab.ui.control.Button
        EditField           matlab.ui.control.NumericEditField
        Label               matlab.ui.control.Label
        TextArea            matlab.ui.control.TextArea
        UIAxes              matlab.ui.control.UIAxes
    end


    methods (Access = private)

        function [Y,Xf,Af] = predict(X)
            % ===== NEURAL NETWORK CONSTANTS =====

            % Input 1
            x1_step1.xoffset = [60;60;60;56;47;59;411;355;59;61];
            x1_step1.gain = [0.0555555555555556;0.0512820512820513;0.0540540540540541;0.0512820512820513;0.032258064516129;0.0540540540540541;0.0106951871657754;0.00995024875621891;0.0625;0.0512820512820513];
            x1_step1.ymin = -1;

            % Layer 1
            b1 = [-2.1418593888213099952;-0.93991026775499897372;3.7107202845933500157;1.6814787027304187728;0.28173717135518161481;-3.7271817565103564363;0.053515799926209639548;1.0958960726637838601;-7.3419165785261668589;-2.0181317512481045107];
            IW1_1 = [-1.4032964259911993032 2.5678983445801604191 -6.2401678116828103171 7.3621697888574226809 12.325906343659104536 1.8323253021029493048 -1.1996661784024262865 -4.845367500021174223 3.1471412837824508379 2.4521166389559709842;0.23570783106644704885 -0.72266405807223321744 -0.73611437510829891284 -0.2022766306792183888 -0.34203211140231526421 2.6394508601770434453 1.2192172897332600456 -0.6932452498842800459 -2.1957902386868815015 -0.90860164541377530512;-13.375471549905252999 14.3110839362817579 -0.50425396898042973426 2.4397569709885238431 -12.428240091807730039 5.7792084133793686362 1.6676782301528272345 -0.5906537539140941373 -0.61160194121109912047 1.2704442556712352008;1.4330576234358103349 1.6177035468574707533 0.62795775545164844722 0.081029752493914683487 -1.1195953674344196749 2.5587518935382358443 -4.1001482552459176389 -2.5824974387994505953 0.12443047400895775045 -2.53277218775480506;2.8966332349107912769 3.3425836394806647256 2.6460991988512185813 -0.26831658684442244445 0.043595895867779427268 1.3404549805395675754 -7.4322832116916384138 -0.36456520043552986809 0.43393065472635228286 -0.65135873800089338914;7.9299098753245811366 1.0984734611982307495 -0.03434961487049170703 2.4266752865746479273 4.9883488973897964769 -9.3231239988285121711 -4.5995190002437347232 5.2304837404540673873 0.6850638237481296855 -4.5322716262196713899;1.8332763381883159237 2.5379081722909964114 2.2780536638055459697 -0.51787466927681469198 -0.22937517692309200568 -0.92514693792032764996 -6.5543573995644210939 0.17349429490507126128 1.1352242220881905155 -0.08107377995901200729;0.43538915396637500876 14.619504447474270137 4.3166745202131799886 3.8034553654483906904 -8.7006939260698050731 -13.337708394776496945 2.2744676177892557689 -18.574950381242409492 0.32404252524060633833 -0.76806112493751277359;-1.3009896487580505653 1.0942040719779653202 0.57871880628489336118 -0.62659934316402388088 -0.54946530473212429335 0.76319954812028745206 -0.97278298265880724927 2.4024809400617765931 -0.34965023723521532206 1.112931189476853211;-10.939255407470138692 9.6828739898127604846 4.2913960187673572122 7.3729123233475331034 8.5483421374800077075 -2.9174694466925217284 -3.3712050864973686082 -7.4569017329004410044 -0.39236757640036679096 2.7014597902443080457];

            % Layer 2
            b2 = 3.9292993270979694742;
            LW2_1 = [-0.0070589213098827471859 -0.25541039120577718746 -0.019946454495339910329 -0.2149312225435011936 0.35876492437749490927 0.03203177128224208442 -0.46230462531913923963 -0.0030162137397070293635 3.9220962351826686998 0.0063152512158789666369];

            % Output 1
            y1_step1.ymin = -1;
            y1_step1.gain = 0.013249092431337;
            y1_step1.xoffset = 278.687968309859;

            % ===== SIMULATION ========

            % Format Input Arguments
            isCellX = iscell(X);
            if ~isCellX
                X = {X};
            end

            % Dimensions
            TS = size(X,2); % timesteps
            if ~isempty(X)
                Q = size(X{1},2); % samples/series
            else
                Q = 0;
            end

            % Allocate Outputs
            Y = cell(1,TS);

            % Time loop
            for ts=1:TS

                % Input 1
                Xp1 = mapminmax_apply(X{1,ts},x1_step1);

                % Layer 1
                a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*Xp1);

                % Layer 2
                a2 = repmat(b2,1,Q) + LW2_1*a1;

                % Output 1
                Y{1,ts} = mapminmax_reverse(a2,y1_step1);
            end

            % Final Delay States
            Xf = cell(1,0);
            Af = cell(2,0);

            % Format Output Arguments
            if ~isCellX
                Y = cell2mat(Y);
            end
        end

        % ===== MODULE FUNCTIONS ========

        % Map Minimum and Maximum Input Processing Function
        function y = mapminmax_apply(x,settings)
            y = bsxfun(@minus,x,settings.xoffset);
            y = bsxfun(@times,y,settings.gain);
            y = bsxfun(@plus,y,settings.ymin);
        end

        % Sigmoid Symmetric Transfer Function
        function a = tansig_apply(n,~)
            a = 2 ./ (1 + exp(-2*n)) - 1;
        end

        % Map Minimum and Maximum Output Reverse-Processing Function
        function x = mapminmax_reverse(y,settings)
            x = bsxfun(@minus,y,settings.ymin);
            x = bsxfun(@rdivide,x,settings.gain);
            x = bsxfun(@plus,x,settings.xoffset);
        end

    end


    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: PredictButton
        function PredictButtonPushed(app, event)
            x1 = double(app.EditField.Value);
            x2 = double(app.EditField_2.Value);
            x3 = double(app.EditField_3.Value);
            x4 = double(app.EditField_4.Value);
            x5 = double(app.EditField_9.Value);
            x6 = double(app.EditField_10.Value);
            x7 = double(app.CET4EditField.Value);
            x8 = double(app.CET6EditField.Value);
            x71 = 100*double(app.CET4EditField.Value)/710;
            x81 = 100*double(app.CET6EditField.Value)/710;
            x9 = double(app.EditField_13.Value);
            x10 = double(app.EditField_14.Value);

            T = [x1,x2,x3,x4,x5,x6,x7,x8,x9,x10]';
            if min(T) < 40 && min(T) > 0
%                 app.EditField_15.Value = 'XXX';
                app.Lamp.Color = 'blue';
                app.Label_10.Text = '考研无路，建议工作';
                app.Label_10.FontColor = 'blue';
                app.EditField_15.Value = predict(T)-20;
                app.EditField_16.Value = -55.1155 + x1^0.9941 + x2^0.8432 + x3^(0.8349) +...
               x4^0.8616 + x5^0.9068 + x6^0.9151 + x71^0.4853 +...
               x81^0.8863 + x9^0.8369 + x10^0.7560-20;
                app.EditField_17.Value = app.EditField_15.Value/500;
                app.EditField_18.Value = app.EditField_15.Value/560;
            elseif min(T) > 50 && app.EditField.Value<=100 && app.EditField_2.Value<=100 && app.EditField_3.Value<=100 && app.EditField_4.Value<=100 && app.EditField_9.Value<=100 && app.EditField_10.Value<=100 && app.EditField_13.Value<=100 && app.EditField_14.Value<=100 && app.CET4EditField.Value<=710 && app.CET6EditField.Value<=710
                app.EditField_15.Value = predict(T)-20;
                app.EditField_16.Value = -55.1155 + x1^0.9941 + x2^0.8432 + x3^(0.8349) +...
               x4^0.8616 + x5^0.9068 + x6^0.9151 + x71^0.4853 +...
               x81^0.8863 + x9^0.8369 + x10^0.7560-20;
                app.EditField_17.Value = app.EditField_15.Value/400;
                app.EditField_18.Value = app.EditField_15.Value/460;
                app.Lamp.Color = 'g';
                app.Label_10.Text = '成绩预测成功仅供参考';
                app.Label_10.FontColor = 'blue';
            else
                app.Lamp.Color = 'r';
                app.Label_10.Text = '输入成绩有误请重新输入';
                app.Label_10.FontColor = 'r';
            end

            x = [2018, 2019, 2020, 2021, 2022];
            y1 = [295, 340, 292, 332, 340];
            y2 = [295, 300, 284, 303, 300];

            plot(app.UIAxes,x, y1,'r*-',x,y2,'b^--')
            legend(app.UIAxes, '专硕','学硕');
            
        end

        % Value changed function: EditField_16
        function EditField_16ValueChanged(app, event)

        end

        % Button down function: UIAxes
        function UIAxesButtonDown(app, event)
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.902 0.902 0.902];
            app.UIFigure.Position = [100 100 617 425];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, '重邮通信初试分数线')
            xlabel(app.UIAxes, '年份')
            ylabel(app.UIAxes, '分数')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.ButtonDownFcn = createCallbackFcn(app, @UIAxesButtonDown, true);
            app.UIAxes.Position = [318 188 300 185];

            % Create TextArea
            app.TextArea = uitextarea(app.UIFigure);
            app.TextArea.HorizontalAlignment = 'center';
            app.TextArea.FontName = '微软雅黑';
            app.TextArea.FontSize = 22;
            app.TextArea.FontColor = [1 1 1];
            app.TextArea.BackgroundColor = [0 0.4471 0.7412];
            app.TextArea.Position = [1 387 617 39];
            app.TextArea.Value = {'  研究生入学考试成绩预测系统'};

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.HorizontalAlignment = 'right';
            app.Label.FontSize = 16;
            app.Label.Position = [24 306 69 22];
            app.Label.Text = '高等数学';

            % Create EditField
            app.EditField = uieditfield(app.UIFigure, 'numeric');
            app.EditField.FontSize = 16;
            app.EditField.Position = [108 306 38 22];

            % Create PredictButton
            app.PredictButton = uibutton(app.UIFigure, 'push');
            app.PredictButton.ButtonPushedFcn = createCallbackFcn(app, @PredictButtonPushed, true);
            app.PredictButton.Position = [397 16 151 32];
            app.PredictButton.Text = 'Predict';

            % Create Label_2
            app.Label_2 = uilabel(app.UIFigure);
            app.Label_2.HorizontalAlignment = 'right';
            app.Label_2.FontSize = 16;
            app.Label_2.Position = [24 247 69 22];
            app.Label_2.Text = '线性代数';

            % Create EditField_2
            app.EditField_2 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_2.FontSize = 16;
            app.EditField_2.Position = [108 247 38 22];

            % Create Label_3
            app.Label_3 = uilabel(app.UIFigure);
            app.Label_3.HorizontalAlignment = 'right';
            app.Label_3.FontSize = 16;
            app.Label_3.Position = [40 188 53 22];
            app.Label_3.Text = '概率论';

            % Create EditField_3
            app.EditField_3 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_3.FontSize = 16;
            app.EditField_3.Position = [108 188 38 22];

            % Create Label_4
            app.Label_4 = uilabel(app.UIFigure);
            app.Label_4.HorizontalAlignment = 'right';
            app.Label_4.FontSize = 16;
            app.Label_4.Position = [24 129 69 22];
            app.Label_4.Text = '通信原理';

            % Create EditField_4
            app.EditField_4 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_4.FontSize = 16;
            app.EditField_4.Position = [108 129 38 22];

            % Create Label_6
            app.Label_6 = uilabel(app.UIFigure);
            app.Label_6.HorizontalAlignment = 'right';
            app.Label_6.FontSize = 16;
            app.Label_6.Position = [7 71 85 22];
            app.Label_6.Text = '信号与系统';

            % Create EditField_9
            app.EditField_9 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_9.FontSize = 16;
            app.EditField_9.Position = [108 71 38 22];

            % Create Label_7
            app.Label_7 = uilabel(app.UIFigure);
            app.Label_7.HorizontalAlignment = 'right';
            app.Label_7.FontSize = 16;
            app.Label_7.Position = [157 304 101 22];
            app.Label_7.Text = '数字信号处理';

            % Create EditField_10
            app.EditField_10 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_10.FontSize = 16;
            app.EditField_10.Position = [273 304 38 22];

            % Create CET4EditFieldLabel
            app.CET4EditFieldLabel = uilabel(app.UIFigure);
            app.CET4EditFieldLabel.HorizontalAlignment = 'right';
            app.CET4EditFieldLabel.FontSize = 16;
            app.CET4EditFieldLabel.Position = [212 245 46 22];
            app.CET4EditFieldLabel.Text = 'CET4';

            % Create CET4EditField
            app.CET4EditField = uieditfield(app.UIFigure, 'numeric');
            app.CET4EditField.FontSize = 16;
            app.CET4EditField.Position = [273 245 38 22];

            % Create CET6EditFieldLabel
            app.CET6EditFieldLabel = uilabel(app.UIFigure);
            app.CET6EditFieldLabel.HorizontalAlignment = 'right';
            app.CET6EditFieldLabel.FontSize = 16;
            app.CET6EditFieldLabel.Position = [212 187 46 22];
            app.CET6EditFieldLabel.Text = 'CET6';

            % Create CET6EditField
            app.CET6EditField = uieditfield(app.UIFigure, 'numeric');
            app.CET6EditField.FontSize = 16;
            app.CET6EditField.Position = [273 187 38 22];

            % Create Label_8
            app.Label_8 = uilabel(app.UIFigure);
            app.Label_8.HorizontalAlignment = 'right';
            app.Label_8.FontSize = 16;
            app.Label_8.Position = [173 129 85 22];
            app.Label_8.Text = '毛泽东概论';

            % Create EditField_13
            app.EditField_13 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_13.FontSize = 16;
            app.EditField_13.Position = [273 129 38 22];

            % Create Label_9
            app.Label_9 = uilabel(app.UIFigure);
            app.Label_9.HorizontalAlignment = 'right';
            app.Label_9.FontSize = 16;
            app.Label_9.Position = [173 71 85 22];
            app.Label_9.Text = '马克思原理';

            % Create EditField_14
            app.EditField_14 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_14.FontSize = 16;
            app.EditField_14.Position = [273 71 38 22];

            % Create EditField_15
            app.EditField_15 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_15.FontSize = 16;
            app.EditField_15.Position = [488 159 100 22];

            % Create Lamp
            app.Lamp = uilamp(app.UIFigure);
            app.Lamp.Position = [13 398 20 20];
            app.Lamp.Color = [0.502 0.502 0.502];

            % Create Label_10
            app.Label_10 = uilabel(app.UIFigure);
            app.Label_10.HorizontalAlignment = 'center';
            app.Label_10.FontSize = 14;
            app.Label_10.Position = [31 12 267 36];
            app.Label_10.Text = {'请输入对应科目的考试成绩'; '（满分：100分）'};

            % Create Label_11
            app.Label_11 = uilabel(app.UIFigure);
            app.Label_11.HorizontalAlignment = 'right';
            app.Label_11.FontSize = 16;
            app.Label_11.Position = [340 126 133 22];
            app.Label_11.Text = '多元线性回归预测';

            % Create EditField_16
            app.EditField_16 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_16.ValueChangedFcn = createCallbackFcn(app, @EditField_16ValueChanged, true);
            app.EditField_16.FontSize = 16;
            app.EditField_16.Position = [488 126 100 22];

            % Create BPLabel
            app.BPLabel = uilabel(app.UIFigure);
            app.BPLabel.FontSize = 16;
            app.BPLabel.Position = [353 159 123 22];
            app.BPLabel.Text = 'BP神经网络预测';

            % Create Label_12
            app.Label_12 = uilabel(app.UIFigure);
            app.Label_12.HorizontalAlignment = 'right';
            app.Label_12.FontSize = 16;
            app.Label_12.Position = [356 96 117 22];
            app.Label_12.Text = '专硕录取成功率';

            % Create EditField_17
            app.EditField_17 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_17.FontSize = 16;
            app.EditField_17.Position = [488 96 100 22];

            % Create Label_13
            app.Label_13 = uilabel(app.UIFigure);
            app.Label_13.FontSize = 16;
            app.Label_13.Position = [591 95 25 22];
            app.Label_13.Text = '%';

            % Create Label_14
            app.Label_14 = uilabel(app.UIFigure);
            app.Label_14.FontSize = 16;
            app.Label_14.Position = [591 64 25 22];
            app.Label_14.Text = '%';

            % Create Label_15
            app.Label_15 = uilabel(app.UIFigure);
            app.Label_15.HorizontalAlignment = 'right';
            app.Label_15.FontSize = 16;
            app.Label_15.Position = [356 65 117 22];
            app.Label_15.Text = '学硕录取成功率';

            % Create EditField_18
            app.EditField_18 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_18.FontSize = 16;
            app.EditField_18.Position = [488 65 100 22];

            % Create Label_16
            app.Label_16 = uilabel(app.UIFigure);
            app.Label_16.FontSize = 18;
            app.Label_16.Position = [24 340 241 24];
            app.Label_16.Text = '请在此处输入本科阶段成绩：';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = scoreforecast_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end