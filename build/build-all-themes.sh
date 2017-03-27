#!/usr/bin/env bash

function build_css
{
    # $1 is "bootswatch" or "semantic-ui"
    category=$1
    dist_dir=dist
    mkdir -p $dist_dir/$category

    for theme in configs/$category/*
    do
        theme_filename=${theme##*/}
        theme_name=${theme_filename%%.*}

        cp $theme ../src/theme.config
        echo "cp $theme ../src/theme.config"

        cd ..

        # build theme CSS files
        echo "Building theme: $theme_name"
        gulp build-css

        # copy theme CSS file to semantic.${theme-name}.{min}.css
        cp dist/semantic.css build/$dist_dir/$category/semantic.$theme_name.css
        cp dist/semantic.min.css build/$dist_dir/$category/semantic.$theme_name.min.css

        cd build
    done
}

cp semantic.json ../

build_css "bootswatch"
build_css "semantic-ui"
