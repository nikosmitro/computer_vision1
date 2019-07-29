function y =get_sigma_from_psnr(signal,desired_ssnr)
y = (max(signal(:))-min(signal(:)))*(10^(-desired_ssnr./20));
end
