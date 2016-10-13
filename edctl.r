#edit ctl file for iBPP

ctls <- scan('name.ctl',sep='\n',what='character');
tres <- scan('ibpp.nwk',sep='\n',what='character');
probs <- read.csv('probs.csv', header = FALSE);
mcmcN <- round(probs * 1000000);

for(iter in 1:1739){
	outpattern <- '(out)([[:digit:]]+)(.txt)';
	outreplace <- paste('out',iter,'.txt',sep ='');
	testctl<-gsub(outpattern,outreplace,ctls);
	mcmcpattern <- '(mcmc)([[:digit:]]+)(.txt)';
	mcmcreplace <- paste('mcmc',iter,'.txt',sep ='');
	tempctl <- gsub(mcmcpattern,mcmcreplace,testctl);
	trereplace <- paste('                  ',tres[iter],sep = '');
	tempctl[18] <- trereplace;
	nsamreplace <- paste('       nsample = ',mcmcN[iter,], sep = '');
	tempctl[43] <- nsamreplace;
	filename <- paste(iter,'.ctl',sep='');
	write.table(tempctl, file = filename, quote = FALSE,row.names=FALSE,col.names=FALSE);
}