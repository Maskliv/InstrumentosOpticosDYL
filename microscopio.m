function [salidaPura, imagenObservacion,pupila] = microscopio(imagenEntrada,M,f2,AN,Nx,Ny,dx,dy, waveLength)

% Definición de unidades de trabajo 
nm = 1E-9;
um = 1E-6;
mm = 1E-3;


% Esta función representa la imagen de salida de un montajepieza optico compuesto
% de dos lentes delgadas identicas, separadas por dos veces su distancia
% focal, los planos de entrada y salida ubicados a una distancia focal de
% la primera y segunda lente respectivamente, el punto medio entre ambas
% lentes se conocerá como plano de fourier

% Nota 1: la imagenEntrada y el filtroPlanoFourier deben tener el mismo
% tamaño y un solo canal en primera instancia


% Procedimiento

% 1. Se calculan los parametros del sistema. 

f1 = f2/M; 


df_0 = (waveLength*f1/(Nx*dx))

rpupila = f1*AN % En dimensiones de espacio 
rpupilaf = (1/(Nx*rpupila))/df_0 %En dimensiones de frecuencia

% 2. Se genera la pupila dependiente de los parametros físicos del sistema.

pupila = filtroCircular ([Nx/2 Ny/2],rpupilaf,[Ny Nx]);

% 3. Se simula el paso a través de la primera lente, si se asume lambda *f = 1
% de acuerdo a lo visto en clase tenemos que al pasar por la
% lente la imagen de entrada quedaria trnasformada en el plano de fourier 
% así:

planoFourier = -1i* fftshift(fft2(imagenEntrada));

% 4. Si allí en el plano de fourier se coloca un filtro de cualquier
% morfología o incluso de fase este afectará a la onda en el plano de
% fourier como una función de trnasmitancia

planoFourierFiltrado = planoFourier .* pupila;

% 5. La imagen de salida será de nuevo aplicar la transformada de fourier
% de lo que sea que haya ocurrido en el plano de fourier ya que está
% distribución de intensidad y fase pasan de nuevo por la lente

salidaPura = -1i * (fft2(planoFourierFiltrado));

% 6. El ojo humano observaria 


imagenObservacion = (abs(salidaPura).^2);

end