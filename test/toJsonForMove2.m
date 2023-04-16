
filename="d:\\csimove2\\test\\dat\\plase7-8-9.dat";
% Создаём json файл и обнуляем его
fnid=fopen(filename + ".json",'w');
fclose('all');
fid=fopen(filename + ".json",'a');
stringJSON="[";
fprintf(fid, stringJSON); 

    % Количество поднесущих
    toto=56;
    %filename="d:\\!Astafiev_CSI\\Движение\\csiTry.dat";
    Fmas = read_log_file(filename);
    % Переменная хранения количества неполных записей
    brokenLines = 0;
    stringJSON = "";
    for i = 1:length(Fmas)
        cCell = Fmas{i}.csi;
        if (cCell~=0) % Проверим не пустое ли значение
            % Если набор данных полный т.е. выкидываем записи по 56
            % поднесущих
            if (length(cCell)==toto)

            for j = 1:toto
                % Формируем запись формата {ffr:?, ffi:?, fsr:?, fsi:?, sfr:?, sfi:?, ssr:?, ssi:?}
                stringJSON=stringJSON+"{" ;
                % С первой антенны на первую
                objCSI.ffr = string(real(cCell(1,1,j)));
                stringJSON=stringJSON+char(34)+"ffr"+char(34)+":"+objCSI.ffr+", ";
                objCSI.ffi = string(imag(cCell(1,1,j)));
                stringJSON=stringJSON+char(34)+"ffi"+char(34)+":"+objCSI.ffi+", ";

                % С первой антенны на вторую
                objCSI.fsr = string(real(cCell(1,2,j)));
                stringJSON=stringJSON+char(34)+"fsr"+char(34)+":"+objCSI.fsr+", ";
                objCSI.fsi = string(imag(cCell(1,2,j)));
                stringJSON=stringJSON+char(34)+"fsi"+char(34)+":"+objCSI.fsi+", ";
                
                % Со второй антенны на первую
                objCSI.sfr = string(real(cCell(2,1,j)));
                stringJSON=stringJSON+char(34)+"sfr"+char(34)+":"+objCSI.sfr+", ";
                objCSI.sfi = string(imag(cCell(2,1,j)));
                stringJSON=stringJSON+char(34)+"sfi"+char(34)+":"+objCSI.sfi+", ";

                % Со второй антенны на вторую
                objCSI.ssr = string(real(cCell(2,2,j)));
                stringJSON=stringJSON+char(34)+"ssr"+char(34)+":"+objCSI.ssr+", ";
                objCSI.ssi = string(imag(cCell(2,2,j)));
                stringJSON=stringJSON+char(34)+"ssi"+char(34)+":"+objCSI.ssi;
                              
                % Закрыть скобку
                if ((j==toto)&&(i==length(Fmas)))%length(Fmas)
                        stringJSON=stringJSON+"}";
                    else
                        stringJSON=stringJSON+"},\n";
                end
                fprintf(fid, stringJSON); 
                stringJSON="";
            end
            else
                brokenLines = brokenLines + 1;
            end % Конец условия обхода неполных записей
        end
    end

disp("Количество неполных записей: " + brokenLines)
stringJSON=stringJSON+"]"
fprintf(fid, stringJSON);
fclose('all');

