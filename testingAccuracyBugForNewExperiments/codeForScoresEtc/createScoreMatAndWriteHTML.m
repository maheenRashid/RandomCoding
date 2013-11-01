function createScoreMatAndWriteHTML(folder)
org_folder=pwd();
out_folder=createScoreMat_function(folder);
copyfile('writingHTMLs.m',fullfile(out_folder,'writingHTMLs.m'));
cd (out_folder);
folder=regexpi(folder,'/','split');
folder=folder{end};
writingHTMLs;
cd (org_folder);
end

