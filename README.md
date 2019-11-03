# Dissertation Template

I quickly created a template for the dissertation format requirement at USF.

# Work in progress

Tested and working on:
- **Overleaf**
- **Latexmk**

Miktex should work too. Someone told me that 

### Miktex issues:
- `\RequirePackage{color}` may be needed. I believe [here](https://github.com/jailby/dissertation_template/blob/master/Latex/usfmanus.cls#L11). This may be fixed by [PR #1](https://github.com/jailby/dissertation_template/pull/1). If you are using miktex and can confirm that pls send a PR :)
- "Table" and "Figure" labels don't show properly in the lot and lof. **Solution:** [for lot](https://github.com/jailby/dissertation_template/blob/master/Latex/usfmanus.cls#L375) and [for lof](https://github.com/jailby/dissertation_template/blob/master/Latex/usfmanus.cls#L358) the label, Figure or Table, should be added before `\ifnum` (This is a hack). I believe that by default it should add the label but Miktex may need it explicitly or something else is conflicting with the label. 


# Contributions

If the format requirement changes, or it does not compile for you and you want to submit a pull request (PR) please send a PR per change (like that I can review and accept quickly). KISS, Keep It Stupid Simple. Try tominimize the number of lines changed.

Good luck :)

# Thanks

Thanks to [anwesht](https://github.com/anwesht/) for the PR to make it work for Latexmk

Thanks to Zach Beasley for the info about Miktex
