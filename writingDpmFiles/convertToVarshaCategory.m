
function [catConverted]=convertToVarshaCategory(catNum)
catConverted=0;
switch catNum
    case 1
        catConverted=8;
        %break;
    case 2
        catConverted=9;
        %break;
    case 3
        catConverted=12;
        %break;
    case 4
        catConverted=10;
        %break;
    case 5
        catConverted=11;
        %break;
    case 6
        catConverted=12;
        %break;
    case 7
        catConverted=12;
        %break;
    case 8
        catConverted=11;
        %break;
    case 9
        catConverted=11;
        %break;
    case 10
        catConverted=3;
        %break;
    case 11
        catConverted=1;
        %break;
    case 12
        catConverted=2;
        %break;
    case 13
        catConverted=4;
        %break;
    case 14
        catConverted=5;
        %break;
    case 15
        catConverted=7;
        %break;
    case 16
        catConverted=6;
        %break;
    case 17
        catConverted=13;
        %break;
    case 18
        catConverted=14;
        %break;
end
catConverted
end