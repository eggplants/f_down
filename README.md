# How to use
This enables you to thread data (consist of html+pics) of [futabachannel](https://www.2chan.net/) via [tsumanne.net](https://tsumanne.net/).　　
- This work on terminal. Execute "index.rb" at first.　　
- You can choose directory where save the files. Please change "/tool/save_dir.txt".
# functions
1,download by single-index  
- select a single index in tsumanne, the threads data have this one try to bulk download.  

2,download by multi-index  
- select some indexes, threads data have this ones try to bulk download.  

3,analyse existing index  
- update index data (accumulated on csv) with new data  

4,look up existense of index  
- search on which board the index is registered,with csv data of index  

5,search threads by index  
- select some indexes, threads data have this ones try to search.
# Contains
.
├── csv  
│├── category_my.csv  
│├── category_sa.csv  
│├── category_si.csv  
│├── category_sp.csv  
│├── category_tj.csv  
│└── not_found.csv  
├── style  
│├── th.css  
│└── th.js  
└── tool  
 ├── down_multi_index.rb  
 ├── down_single_index.rb  
 ├── exist_index.rb  
 ├── index.rb  
 ├── save_dir.txt  
 ├── search_cath.rb  
 └── search_thread_by_index.rb  
  
3 directories, 15 files  
