#!/usr/bin/env bash
#
# download_assets.sh
# ------------------
# One-time helper: downloads all images and publication PDFs from the old
# Weebly site into this repo's assets/ folders, so the new site is fully
# self-contained and you can cancel Weebly.
#
# Run it once, from inside the lab-website folder:
#     bash download_assets.sh
#
# Requires: curl (preinstalled on macOS and Linux).
# After it finishes, commit the assets/ folder and push to GitHub.

set -u
BASE="https://tylerbonnell.weebly.com/uploads/3/1/2/4/31244057"
IMG="assets/img"
PDF="assets/pdf"
mkdir -p "$IMG" "$PDF"

fail=0
get () {  # get <url> <destination>
  if curl -fsSL "$1" -o "$2"; then
    echo "  ok   $2"
  else
    echo "  FAIL $2   <-- $1"
    fail=$((fail+1))
  fi
}

echo "Downloading images..."
get "$BASE/100-0006-img-4_orig.jpg"                          "$IMG/home-lab.jpg"
get "$BASE/editor/fin-vamosi.jpeg"                           "$IMG/fin-vamosi.jpeg"
get "$BASE/1471888822.png"                                   "$IMG/collective-movement-1.png"
get "$BASE/algorithm-groupmate2_orig.png"                    "$IMG/collective-movement-2.png"
get "$BASE/published/img-0431c_1.jpg"                        "$IMG/social-networks-1.jpg"
get "$BASE/published/multilayernet-horizontal.png"           "$IMG/social-networks-2.png"
get "$BASE/published/picture1.png"                           "$IMG/social-ecological-1.png"
get "$BASE/published/blv180621-1060-dl-marquage-gremm-bed.jpeg" "$IMG/social-ecological-2.jpeg"

echo "Downloading recruitment + publication PDFs..."
PDFS=(
  phd_dynsoc.pdf
  marine_mammal_science_-_2024_-_bonnell_-_estimating_spatial_mixing_within_the_st__lawrence_estuary_beluga_population_by.pdf
  logue-bonnell-2023-skewed-performance-distributions-as-evidence-of-motor-constraint-in-sports-and-animal-displays.pdf
  vilette_2023_strongties.pdf
  american_j_primatol_-_2023_-_henzi.pdf
  s10750-022-04980-z.pdf
  american_journal_of_biological_anthropology_-_2023_-_blersch.pdf
  vazquez-cardona_2023_vocalperf.pdf
  stupl_2023_simulating_the_evolution_of_height_in_the_netherlands_in_recent_history.pdf
  bonnell_2023_nrn.pdf
  vilette_2022_netformationjuves.pdf
  nord_2022_fearofmissingout.pdf
  bonnell_2022_synchronyinnetworks.pdf
  langois_2022_underwaternoise.pdf
  bonnell-extractingspatialnetworksfromcapturerecapturedatarevealsindividualsite_2022.pdf
  mcfarland_2022_fevers.pdf
  blersch_2022_sickandtired.pdf
  henzietal2021.pdf
  chionetal.mpb_2021.pdf
  journal_of_zoology_-_2021_-_blersch.pdf
  adams_2021_coreunits.pdf
  piefke_2022_socialstability.pdf
  nord_2021_muzzlecontact_tolerance.pdf
  green2020_leastcost_chimp.pdf
  vilette_2020_rankingreliability.pdf
  bonnell_et_al_2020_dynamic_multilayer_networks_vervets.pdf
  bonnell_et_al-2020-methods_in_ecology_and_evolution__1_.pdf
  jarrett_et_al-2020-american_journal_of_physical_anthropology.pdf
  young_et_al_2020_climate_stress_vervets.pdf
  bonnell_et_al_2018_functional_social_structures_baboons.pdf
  kessler_et_al_socialstructure_evo_diseasecontrol.pdf
  bonnell_et_al_2018_landsacpeconfiguration_loss_envparasite.pdf
  chapman_et_al-2018-biotropica__1_.pdf
  jarrett_et_al_2018_networkint_socialinheritance_vervets.pdf
  bonnell_et_al_2017_individual_movement_bias.pdf
  kessler2017_diseaserecog.pdf
  behavioral_ecology-2016-bonnell-beheco-arw145.pdf
  bonnell_et_al_2016_landscapehostparasite_climateandlandscapes.pdf
  dostie_et_al_2016_adaptivegeometry_socialforagers.pdf
  bonnell_et_al_2016_scale_and_scheduling_choices_abm.pdf
  josephs2016_be_in_press.pdf
  schoof2016_wfc_seasonal_hormone_variation_ajpa.pdf
  reynahurtado2015_groupsizewhite-lippedpeccary_biotropica_2015.pdf
  chapman2015_diseasenutritionstress_abundance.pdf
  gogarten2014_increasinggroupsize_behaviour.pdf
  jacob2014_wetlandclass_kibale.pdf
)
for f in "${PDFS[@]}"; do
  get "$BASE/$f" "$PDF/$f"
done

echo
if [ "$fail" -eq 0 ]; then
  echo "Done — all assets downloaded successfully."
else
  echo "Done, but $fail file(s) failed. Re-run to retry, or download those"
  echo "manually from the old Weebly site and drop them into assets/."
fi
