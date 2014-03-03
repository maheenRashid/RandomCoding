function [ap]=getAP(prec,recall)
ap = trapz(recall(end:-1:1),prec(end:-1:1));

end