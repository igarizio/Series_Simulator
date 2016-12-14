classdef DataGenerator

    methods(Static)
	
        function serie = gen_white_noise(n_datos)
            serie = randn(n_datos, 1);
        end
        
        function serie = gen_ar(n_datos, coefs)
            serie = zeros(n_datos + length(coefs), 1);
            w_noise = DataGenerator.gen_white_noise(n_datos + length(coefs));
            
            for i = length(coefs) + 1:n_datos+length(coefs)
                serie(i) = serie(i) + coefs(1) + w_noise(i);
                for j = 1:length(coefs)-1
                    serie(i) = serie(i) + serie(i - j)*coefs(j + 1);
                end
            end
            serie = serie(length(coefs)+1:end); %eliminamos los primeros elementos
        end
        
        function serie = gen_ma(n_datos, coefs)
            serie = zeros(n_datos, 1);
            w_noise = DataGenerator.gen_white_noise(n_datos + length(coefs));
            
            for i = length(coefs)+1:n_datos+length(coefs)
                serie(i - length(coefs)) = serie(i - length(coefs)) + coefs(1);
                for j = 1:length(coefs)-1
                    serie(i - length(coefs)) = serie(i - length(coefs)) + w_noise(i - j - 1)*coefs(j + 1);
                end
            end
        end
		
        function serie = gen_arma(n_datos, coefs_ar, coefs_ma)
            ma = DataGenerator.gen_ma(n_datos, coefs_ma);
            serie = zeros(n_datos + length(coefs_ar), 1);
            
            for i = length(coefs_ar) + 1:n_datos+length(coefs_ar)
                serie(i) = serie(i) + coefs_ar(1) + ma(i-length(coefs_ar)); %ac� no us� e_t, porque e_t ya est� en el ma
                for j = 1:length(coefs_ar)-1
                    serie(i) = serie(i) + serie(i - j)*coefs_ar(j + 1);
                end
            end
            serie = serie(length(coefs_ar)+1:end); %eliminamos los primeros elementos
        end
		
    end
end


