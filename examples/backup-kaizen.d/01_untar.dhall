{ name = "untar"
, inpatterns = [
    GlobOne "*.tar*" -- glob and invoke once per match
  ]
, outpaths = \(inpaths: List Text) -> [
    -- TODO can this be in dhall? if not, maybe dhall isn't the right lang? :(
    Eval "basename '${List/head Text inpaths}'"
  ]
-- , describe =
--     \(inpaths: List Text) ->
--     \(outpaths: List Text) ->
--     let inpath  = List/head Text inpaths
--     let outpath = List/head Text outpaths
--     in "untar ${inpath} -> ${outpath}"
}
