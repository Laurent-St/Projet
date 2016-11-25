function signal_reel = s_reel(env_c, fc, t)

signal_reel = real(env_c).*cos(2*pi*fc.*t) + imag(env_c).*sin(2*pi*fc.*t);