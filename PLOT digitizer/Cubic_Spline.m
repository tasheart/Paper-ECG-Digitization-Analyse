function [ yCS, dyCS ] = Cubic_Spline( x, y, xCS )
%Å¥ºò ½ºÇÃ¶óÀÎÀ» ÀÌ¿ëÇÏ¿© ÇÔ¼ö°ª, ¹ÌºÐ°ªÀ» ±¸ÇÔ
    n = length(x);
    h = zeros(1, n-1);
    v = zeros(1, n-1);
    for i = 1:1:n-1
        h(i) = x(i+1)-x(i);
        if( i ~= 1 )        %V´Â 2ºÎÅÍ ½ÃÀÛÇÑ´Ù.
            v(i) = 6*((y(i+1) - y(i))/h(i) - (y(i) - y(i-1))/h(i-1));
        else
            continue;
        end        
    end
    A = zeros(n);
    b = zeros(n, 1);
    pA = zeros(n-2);            %AÀÇ 2~n-1¹øÂ° row
    pb = zeros(n-2, 1);         %bÀÇ 2~n-1¹øÂ°
    
    A(1, 1) = 1;
    A(1, 2) = -(1 + h(1)/h(2));
    A(1, 3) = h(1)/h(2);
    for i = 2:1:n-1
        A(i, i-1) = h(i-1);
        A(i, i  ) = 2*(h(i) + h(i-1));
        A(i, i+1) = h(i);
        b(i)      = v(i);
    end
    A(n, n-2) = h(n-1)/h(n-2);
    A(n, n-1) = -(1 + h(n-1)/h(n-2));
    A(n, n-0) = 1;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %to the tridiagonal matrix
    %Second Row
    b(2) = b(2) - b(1)*A(2, 1)/A(1, 1);
    A(2, :) = A(2, :) - A(1, :)*A(2, 1)/A(1, 1);    
    %n-1th Row
    b(n-1) = b(n-1) - b(n)*A(n-1, n)/A(n, n);
    A(n-1, :) = A(n-1, :) - A(n, :)*A(n-1, n)/A(n, n);    
    
    for i = 1:1:n-2
        for j = 1:1:n-2
            pA(i, j) = A(i+1, j+1);
        end
        pb(i) = b(i+1);
    end
    Mt = pA\pb;                 %M temp. M2~Mn-1
    %ÀÌÈÄ ¼öµ¿ÀûÀ¸·Î Çª´Â °ÍÀÌ ÈÎ¾À ´õ ºü¸§
    b(1) = b(1) - A(1, 2)*Mt(1);        b(1) = b(1) - A(1, 3)*Mt(2);
    b(1) = b(1) / A(1, 1);
    b(n) = b(n) - A(n, n-2)*Mt(n-3);    b(n) = b(n) - A(n, n-1)*Mt(n-2);
    b(n) = b(n) / A(n, n);
    M = [b(1);Mt;b(n)];

    a = zeros(4, n-1);
    for i = 1:1:n-1
        a(1, i) = y(i);
        a(2, i) = (y(i+1)-y(i))/h(i) - (M(i+1) + 2*M(i))*h(i)/6;
        a(3, i) = M(i) / 2;
        a(4, i) = (M(i+1) - M(i))/(6*h(i));
    end
    
    
    sizeCS = length(xCS);
    ni = 1;
    yCS  = 0*xCS;
    dyCS = 0*xCS;
    for i = 1:1:sizeCS
        for ni = 1:1:n-1        % °³¼± ÇÊ¿äÇÔ (±»ÀÌ ·çÇÁ µ¹ ÀÌÀ¯°¡ ¾øÀ½)
            if(  (x(ni)-xCS(i))*(x(ni+1)-xCS(i)) <= 0 )
                yCS(i) = [1, (xCS(i)-x(ni)), (xCS(i)-x(ni))^2, (xCS(i)-x(ni))^3]*a(:, ni);
                dyCS(i) = [0, 1, 2*(xCS(i)-x(ni)), 3*(xCS(i)-x(ni))^2]*a(:, ni);
                break;
            end            
        end
    end
    
end

