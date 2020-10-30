% Emma Akbari (eea21) hw8
function [loss] = cross_entropy_loss(scores, correct_class);
% Part II: Loss Functions: 2

e = exp(scores)/sum(exp(scores));
loss = -log(e(correct_class));