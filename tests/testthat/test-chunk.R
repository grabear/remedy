testthat::context("chunks")

if(rstudioapi::isAvailable()){
  
  path <- tempfile(pattern = 'test',fileext = '.R')
  file.create(path)
  rstudioapi::navigateToFile(path)
  Sys.sleep(1)
  sec <- rstudioapi::getSourceEditorContext()
  
}

testthat::describe('splitting',{
  
  skip_if_not_rstudio()
  testthat::skip_on_travis()
  
  it('splitting one chunk into two',{
    
    set_text(txt = '```{r}\n \n```',sec = sec)
    
    rstudioapi::setCursorPosition(rstudioapi::document_position(2,1),id = sec$id)
    
    chunksplitr()
    
    rstudioapi::documentSave(sec$id)
        
    testthat::expect_equal(readLines(path,warn = FALSE),
                           c('```{r}',' ','```',' ','```{r}','```')
                           )
    set_text(sec = sec)
  })
  
})

testthat::describe('params',{
  
  skip_if_not_rstudio()
  testthat::skip_on_travis()
  
  it('splitting one chunk into two carrying chunk params',{
    
    set_text(txt = '```{r, echo = FALSE, warnings = TRUE}\n \n```',sec = sec)
    
    rstudioapi::setCursorPosition(rstudioapi::document_position(2,1),id = sec$id)
    
    chunksplitr()
    
    rstudioapi::documentSave(sec$id)
    
    testthat::expect_equal(readLines(path,warn = FALSE),
                           c('```{r, echo = FALSE, warnings = TRUE}',' ','```',' ','```{r, echo = FALSE, warnings = TRUE}','```')
    )
    set_text(sec = sec)
  })
  
})

testthat::describe('creating',{
  
  skip_if_not_rstudio()
  testthat::skip_on_travis()
  
  it('full document',{
    
    set_text(txt = '',sec = sec)
    
    chunkr()

    rstudioapi::documentSave(sec$id)
        
    testthat::expect_equal(readLines(path,warn = FALSE),
                           c('', '```{r remedy001}', '', '```')
    )
    set_text(sec = sec)
  })
  
})

testthat::describe('wrapping',{
  
  skip_if_not_rstudio()
  testthat::skip_on_travis()
  
  it('full document',{
    
    set_text(txt = 'aaa',sec = sec,mark = entire_document)
    
    chunkr_section()
    
    rstudioapi::documentSave(sec$id)
    
    testthat::expect_equal(readLines(path,warn = FALSE),
                           c("","```{r remedy001}","aaa","```")
    )
    set_text(sec = sec)
  })
  
})
