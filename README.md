# Targets + Bookdown

I originally used the approach of https://github.com/robitalec/targets-parameterized-bookdown but with that approach **equations will not work**. This renders the chapters to markdown and equations (unless very simple) won't work. But a fairly simple tweak will allow it to work. Basically use `knitr::knit()` instead of `rmarkdown::render()` to create the rendered R Markdown files.

**update** This doesn't work as it breaks all the figure legends from {bookdown}. It replaces images with `<img>` html tags and that loses all the info that {bookdown} needs to make legends. I tried `rmarkdown::render()` with some {bookdown} output formats but couldn't figure out a what to get both the figure legends and refs plus the equations.

This gives an html fragment that can be included but lose all the heading (chapter, section) info.
```
rmarkdown::render("chap2.Rmd", output_format = bookdown::html_fragment2(self_contained = FALSE))
```

This is an attempt to use {targets} with {bookdown} to track the status of chapter and not re-render chapters each time the book needs to be rebuilt. At the book level, the dependencies are super simple, just checks if the chapter Rmd has changed. But for a specific chapter, you can have a separate {targets} pipeline that might be much more complex. {targets} [projects](https://books.ropensci.org/targets/projects.html) is probably a better way to go in that situation.

*Why did I do this?* I have many big bookdown projects and re-building is always a bit of torture. The bookdown caching feature is quite buggy and crashes my R session all the time. Hopefully this works better.


## To run the book

* Install the {targets}, {tarchetypes} and {bookdown} packages
* Type `tar_make()` at the command line.
* Look in the `_book` folder for the `index.html` file and open that.

## To add chapters

* The chapters are in the `chapters` folder. Add an Rmd there.
* Open the `_targets.R` file and add something like `target_factory(chap2)` but replace `chap2` with your file name.
* `chapters/chap3` shows and example where the chapter uses targets markdown to create a chapter specific pipeline. To run, set `chapters/chap3` as the working directory, open `chap3.Rmd` and knit. Then 

## Explanations

* `_targets.R` is setting up the targets objects so {targets} can keep track of when objects need to be updated (because a dependency changed)
* `R/chapterfactory.R` is a file I wrote to create the chapter dependencies and objects. Basically it just renders a chapter Rmd and put the rendered version (md) into the folder `rendered-chapters` folder.
* Use `tar_visnetworks()` to visualize the network and status.

## Re-use statement

Please re-use however you want. No attribution needed.

