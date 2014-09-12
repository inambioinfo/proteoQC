#include <Rcpp.h>
#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include <sstream>
//R Stuff

extern "C" 
{
#include <Rdefines.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>
}


using namespace Rcpp;

RcppExport SEXP ChargeCount_Cpp(SEXP mgf_)
{
	std::string mgf = as<std::string> (mgf_);
	typedef std::map<std::string, int> hash_count;
	hash_count count;


	std::ifstream in(mgf.c_str());
	if(!in)
	{
		return wrap(NA_REAL);
	}
	std::string line;  //每行字符串临时变量
	getline(in, line);//获取一行
    int total=0;
	int ms2flag=0;
	while(in)
	{
        size_t tfound = line.find("BEGIN IONS");
        if(tfound!=std::string::npos)
        {
            total++;
			ms2flag=1;
        }
		size_t endfound = line.find("END IONS");
		if(endfound!=std::string::npos){
			ms2flag=0;
		}
        size_t cfound = line.find("CHARGE=");
        if(cfound!=std::string::npos)
        {
            //std::string charge=line.substr(7,1);
			std::string charge=line.substr(7,std::string::npos);
			if(ms2flag==1){
				count[charge]++;
			}
            //std::cout<<l<<std::endl;
        }
		//std::cout<<line<<std::endl;
		getline(in, line);
	}
	in.close();
    
    Rcpp::List dict(count.size());

    
    int sum=0;
	for(hash_count::iterator it=count.begin();it != count.end();++it)
	{
        dict[it->first]=it->second;
        sum=sum+it->second;
	}
	if(total!=sum){
		dict["0"]=total-sum;
	}
	return(dict);

}


/*
 * fixed the RECOMMENDED "registering-native-routines" of bioconductor'check.
*/
extern "C"
{
    void R_init_proteoQC(DllInfo *dll)
	{
		/*
		 * Register routines,allocate resources.
		 * Currently we call all of the functions whith .Call
		 */
		R_CallMethodDef callEntries[] = {
			{"ChargeCount_Cpp", (DL_FUNC) &ChargeCount_Cpp, 1},
			{NULL,NULL,0}
		};
		R_registerRoutines(dll,NULL,callEntries,NULL,NULL);
	}
	void R_upload_proteoQC(DllInfo *dll)
	{
		/* Release resources. */
	}

}