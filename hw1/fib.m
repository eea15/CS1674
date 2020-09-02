function [val] = fib(n)
    % return n-th number in fibonacci sequence
    if n < 2
        val = n;
    else
        val = fib(n-1) + fib(n-2);
    end
end
    
