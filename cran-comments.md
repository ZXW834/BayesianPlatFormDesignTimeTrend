## R CMD check results

#### There were no ERRORs.

#### There were no WARNINGs:

#### There were 1 NOTE:
##### checking for GNU extensions in Makefiles ... NOTE
#####  *GNU make is a SystemRequirements.

# Mar 13, 2023, BayesianPlatformDesignTimeTrend version 1.0.0 (resubmission)
## Major changes
I fixed some parts commented by the CRAN team, Benjamin Altmann.
I will describe the comments and their solution as follows.

> Please reduce the length of the title to less than 65 characters.

- I reduced the title to "Simulate and analyse Bayesian Platform Trial with time trend""

> Please omit the redundant "This Package" at the start of your title.

- I delete the "This Package" in title

> If there are references describing the methods in your package, please
> add these in the description field of your DESCRIPTION file in the form
> authors (year) <doi:...>
> authors (year) <arXiv:...>
> authors (year, ISBN:...)
> or if those are not available: <[https:...]https:...>
> with no space after 'doi:', 'arXiv:', 'https:' and angle brackets for
> auto-linking. (If you want to add a title as well please put it in
> quotes: "Title")

- I add reference about the analysis and randomisation methods used in this package.

> We see Unexecutable code in man/Randomisation.inf.Rd.
> I believe you have one closing bracket to much there.

- I revise the example in the man/Randomisation.inf.Rd

> You write information messages to the console that cannot be easily suppressed.
> It is more R like to generate objects that can be used to extract the information a user is interested in, and then print() that object.
> Instead of print()/cat() rather use message()/warning() or if(verbose)cat(..) (or maybe stop()) if you really have to write text to the console. (except for print, summary, interactive functions)
> -> R/Demo_CutoffScreening.R; R/Demo_multiplescenariotrialsimulation.R; R/TrialSimulation.R

- I modify the print() functions as follows.
- print("Start trial information initialisation") --> message("Start trial information initialisation")
- print("Start trial information initialisation") --> message("Start trial information initialisation")
- print(
    "Start trial simulation. This is a two arm trial simulation. There are two null scenarios and two alternative scenarios and for each scenario there are two vectors of number of patients at each stage in this demo. There are 8 rounds."
  ) --> message(
    "Start trial simulation. This is a two arm trial simulation. There are two null scenarios and two alternative scenarios and for each scenario there are two vectors of number of patients at each stage in this demo. There are 8 rounds."
  )
- print(paste(
        "Scenario",
        i,
        "with patient number sequence",
        ns[z],
        "under simulation"
      )) --> message(paste(
        "Scenario",
        i,
        "with patient number sequence",
        ns[z],
        "under simulation"
      ))
- print(paste("Finished round", cutoffindex)) --> message(paste("Finished round", cutoffindex))
- print("Start the start grid screening") --> message("Start the start grid screening")
- print(paste("Start the extend grid screening.","There are", grid.inf$extendlength ,"cutoff values under investigation in the extend grid")) --> message(paste("Start the extend grid screening.","There are", grid.inf$extendlength ,"cutoff values under investigation in the extend grid"))
- print(paste("Finished extend grid screening round", cutoffindex)) --> message(paste("Finished extend grid screening round", cutoffindex))
- print("Output data recording") --> message("Output data recording")


> Please make sure that you do not change the user's options, par or working directory. If you really have to do so within functions, please ensure with an *immediate* call of on.exit() that the settings are reset when the function is exited.
> e.g.:
> ...
> old <- options()# code line i
> on.exit(options(old)) # code line i+1
> ...
> options(...)# somewhere after
> ...
> e.g.: -> R/Demo_CutoffScreening.R; R/TrialSimulation.R
> If you're not familiar with the function, please check ?on.exit. This function makes it possible to restore options before exiting a function even if the function breaks. Therefore it needs to be called immediately after the option change within a function.

- I add old <- options() at the beginning of Demo_CutoffScreening.R and TrialSimulation.R
- I add on.exit(options(old)) at the end of Demo_CutoffScreening.R and TrialSimulation.R

# Mar 15, 2023, BayesianPlatformDesignTimeTrend version 1.0.0 (resubmission)
## Major changes
I fixed some parts commented by the CRAN team, Benjamin Altmann.
I will describe the comments and their solution as follows.

> The Title field should be in title case. Current version is:
>   'Simulate and analyse Bayesian Platform Trial with time trend'
> In title case that is:
>   'Simulate and Analyse Bayesian Platform Trial with Time Trend'

- I modified the title to 'Simulate and Analyse Bayesian Platform Trial with Time Trend'

> Please spellcheck your description. It currently reads:
>     "...the R interface for to the Stan. ..." -> "...the R interfacevfor the Stan. ..."

- I revise the spell to "the R interfacev for the Stan"

> Please add the on.exit() call right after defining old <- options(). e.g.: in R/TrialSimulation.R in line 65

- I add the on.exit after old <- option()

> Please always add all authors, contributors and copyright holders in the Authors@R field with the appropriate roles.
> From CRAN policies you agreed to:
>"The ownership of copyright and intellectual property rights of all components of the package must be clear and unambiguous (including from the authors specification in the DESCRIPTION file). Where code is copied (or derived) from the work of others (including from R itself), care must be taken that any copyright/license statements are preserved and
authorship is not misrepresented.
> Preferably, an ‘Authors@R’ would be used with ‘ctb’ roles for the authors of such code. Alternatively, the ‘Author’ field should list these authors as contributors. Where copyrights are held by an entity other than the package authors, this should preferably be indicated via ‘cph’ roles in the ‘Authors@R’ field, or using a ‘Copyright’ field (if necessary referring to an inst/COPYRIGHTS file)."
> e.g.: In your LICENSE file you claim 'PlatFormDesign authors' to be copyrightholder. Do you mean yourself with this?
> Please explain in the submission comments what you did about this issue.

- I have revise the LICENSE file, which was created in previous version. I changed the name of the package after that but did not revise the LICENSE file


# Jun 11, 2023, BayesianPlatformDesignTimeTrend version 1.1.1 (fix bug)
> ## No test: 
> demo_Cutoffscreening.GP(ntrials = 2, cl = 2,
> +     grid.inf = list(
> +     start.length = 10,
> +     confidence.level = 0.95,
> +     grid.length = 5000,
> +     change.scale = FALSE,
> +     noise = TRUE,
> +     errorrate = 0.1,
> +     simulationerror = 0.01,
> +     iter.max = 15,
> +     plotornot = FALSE))
> Start the start grid screening
> Error in sample.int(x, size, replace, prob) : 
>  incorrect number of probabilities
> Calls: demo_Cutoffscreening.GP -> GP.optim -> sample -> sample.int
> Execution halted

- I fixed the bug in function `GP.optim` where the nextcutoff vector for sample may have only one element. This will lead to the error in function `sample` when you only want to sample one value greater than 1.
- The argument 'ntrials' in each example should be large (> 100) instead 2 to make the example more like an actual simulation example. I use ntrials = 2 in the example to speed up the check process.
