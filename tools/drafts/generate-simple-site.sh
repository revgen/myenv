#!/bin/sh
##############################################################################
# Script to generate a simple html file.
#
# Usage: generate-simple-site.sh [output directory]
##############################################################################
export PATH="/usr/bin:${PATH}"
debug() { >&2 echo ${@}; }

gss_load_config() {
    export BG_COLOR1=${BG_COLOR1:-"#4e4e4e"}
    export BG_COLOR2=${BG_COLOR2:-"#3e3e3e"}
    export BG_COLOR3=${BG_COLOR3:-"#6e6e6e"}
    export FC_COLOR1=${FC_COLOR1:-"#fff"}
    export SITE_NAME=${SITE_NAME:-"Simple site"}
    export SITE_LOGO=${SITE_LOGO:-"🌐"}
    export SITE_URL=${SITE_URL:-""}
    export TS=$(date +%s)
    export OUTPUT_DIR=${OUTPUT_DIR:-"${PWD}"}
    export UPDATE_STATIC=${UPDATE_STATIC:-"true"}
    export STATIC_DIR=${STATIC_DIR:-"${OUTPUT_DIR}/static"}
    mkdir -p "${OUTPUT_DIR}"
    debug "Config: SITE_NAME=${SITE_NAME}, SITE_URL=${SITE_URL}, TS=${TS}, OUTPUT_DIR=${OUTPUT_DIR}"
}

gss_copy_static_content() {
    if [ "${UPDATE_STATIC}" == "true" ]; then
        if [ -n "${1}" ]; then
            mkdir -p "${OUTPUT_DIR}/static/images/"
            debug "Download favicon: ${1}"
            wget -O "${OUTPUT_DIR}/static/images/favicon.png" "${1}" || exit 1
        fi
        if [ -z "${STATIC_DIR}" ] && [ -d "${STATIC_DIR}" ]; then
            debug "Coping static content: ${STATIC_DIR} -> ${OUTPUT_DIR}..."
            rsync -av "${STATIC_DIR}/" "${OUTPUT_DIR}/static/"
            debug "A static directory ${STATIC_DIR} not exists. Skip."
        else
            debug "Copy static content complete"
        fi
    else
        debug "Skip coping static content"
    fi
}

gss_styles() {
  echo "  <style>
    /*** Common styles *****************************/
    html, body { margin: 0; padding: 0; height: 100%; }
    body { display: block; overflow: visible; color: ${FC_COLOR1}; background-color: ${BG_COLOR1}; }
    div.page { width: 50%; margin: 0 auto; padding: 0; min-height: 100%;
      border-left: 1px dotted ${BG_COLOR3}; border-right: 1px dotted ${BG_COLOR3}; background-color: ${BG_COLOR2}; }
    div.page a { color: ${FC_COLOR1}; }
    header { margin: 0; padding: 1em 2em; }
    header .title { font-size: 200%; font-weight: bold; color: ${FC_COLOR1}; letter-spacing: 0.1em; }
    header ul.admin-menu { margin: 0; }
    header ul.admin-menu > li { display: inline-block; padding: 0; margin: 0; }
    header ul.admin-menu > li a { text-decoration: none; border-bottom: 2px solid ${BG_COLOR2}; font-weight: bold; }
    header ul.admin-menu > li a:hover { border-bottom: 2px solid ${FC_COLOR1}; }
    footer { position: fixed; bottom: 0; width: 50%; padding: 1em 0; text-align: center; white-space: nowrap; }
    section.content { padding: 0 2em; overflow: auto; }
    .note { font-size: 100%; color: #ccc }
    .right { float: right; }
    .tile { background-color: #6699ff; border-radius: 5px; border: 1px solid ${BG_COLOR3}; margin: 0 3px; padding: 5px; } 
    .tile a { text-decoration: none; }
    .tile.ok { background-color: #339966; }
    .tile.error { background-color: #cc0000; }
    @media only screen and (max-width: 1200px) {
      div.page { width: 80%; }
      footer { width: 80%; }
    }
    @media only screen and (max-width: 768px) {
      div.page { width: 96%; }
      footer { width: 96%; }
      section.content { border: none; padding: 0 0.5em; }
      header { padding: 0.5em 1em; }
      header .title { font-size: 150%; }
      footer { padding: 0.5em 0; }
    }
    /*** Home page styles **************************/
    ul.navbar-nav { list-style-type: none; padding: 0; }
    ul.navbar-nav li { font-size: 120%; padding: 0.5em 2em; text-transform: uppercase; letter-spacing: 0.1em; }
    ul.navbar-nav li.start-group { border-top: 1px dotted ${BG_COLOR3}; }
    ul.navbar-nav li:hover { background-color: #282828; }
    ul.navbar-nav>li>a { color: #fff; text-decoration: none; }
    ul.navbar-nav a:hover, .navbar-nav a:active { color: #337ab7; }
    @media only screen and (max-width: 768px) {
      ul.navbar-nav li { padding: 0.5em 0em; }
    }
  </style>" | grep -v "/\*\*\*"
}

gss_begin_page() {
    page_name=${1}
    create_header_func=${2:-""}
    if [ -z "${page_name}" ] || [ "${page_name}" == "${SITE_NAME}" ]; then title="${SITE_NAME}";
    else title="${page_name} - ${SITE_NAME}"; fi
    debug "Start creating '${title}' page..."
    echo "<!DOCTYPE html><html lang=\"en\"><head> <meta charset=\"UTF-8\">"
    echo "  <title>${title}</title>"
    echo "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\" />"
    echo "  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\" />"
    echo "  <meta http-equiv=\"Cache-Control\" content=\"no-cache, no-store, must-revalidate\" />"
    echo "  <meta http-equiv=\"Pragma\" content=\"no-cache\" />"
    echo "  <meta http-equiv=\"Expires\" content=\"0\" />"
    echo "  <link rel=\"icon\" type=\"image/png\" href=\"${SITE_URL}/static/images/favicon.png?ts=${TS}\" />"
    # echo "  <link rel=\"stylesheet\" href=\"${SITE_URL}/static/css/site.css?ts=${TS}\" />"
    gss_styles
    echo "</head>"
    echo "<body><div class=\"page\">"
    if [ -n "${create_header_func}" ]; then
        debug "Create header using a '${create_header_func}' command"
        echo "  <header>"
        ${create_header_func} "${page_name}"
        echo "  </header>"
    fi
    debug "Create top part of the '${page_name}' page complete."
}

gss_footer_page() {
    page_name=${1}
    create_footer_func=${2:-""}
    page_class=$(echo "${page_name}" | sed 's/ /-/g' | tr A-Z a-z)
    debug "Creating footer for the '${page_name}' page..."
    if [ -n "${create_footer_func}" ]; then
        debug "Create footer using a '${create_footer_func}' command"
        echo "  <footer>"
        ${create_footer_func} "${page_name}"
        echo "  </footer>"
    fi
    echo "  <script type=\"text/javascript\">"
    echo "    const loadContent = (url, elementId) => {"
    echo "      const el = document.getElementById(elementId);"
    echo "      if (!el) { console.debug('Element ' + elementId + ' not found. Skip load url.'); return; }"
    echo "      console.debug('Loading ' + url + '....');"
    echo "      fetch(url).then(resp => resp.text()).then(text => {"
    echo "        el.innerText = text; console.debug('Load ' + url + ' complete.'); })"
    echo "      .catch((err) => console.error('Error load ' + url + ': ' + err + '.'));"
    echo "    };"
    echo "    console.debug('Init ${page_name} page');"
    echo "  </script>"
    debug "Create footer for the '${page_name}' page complete."
}

gss_end_page() {
    page_name=${1}
    create_end_page_func=${2:-""}
    debug "End creating '${page_name}' page..."
    if [ -n "${create_end_page_func}" ]; then
        debug "Create custom end page with '${create_end_page_func}' command"
        ${create_end_page_func} "${page_name}"
    fi
    # echo "  <script type=\"text/javascript\" src=\"${SITE_URL}/static/js/site.js?rev=${TS}\"></script>"
    echo "</div><!-- Generated: $(date +"%Y-%m-%d %H:%M:%S") --></body>"
    echo "</html>"
    debug "Create bottom part of the '${page_name}' page complete."
}

gss_page_content() {
    page_name=${1}
    create_content_func=${2}
    page_class=$(echo "${page_name}" | sed 's/ /-/g' | tr A-Z a-z)
    if [ -n "${create_content_func}" ]; then
        debug "Create content using a '${create_content_func}' command"
        echo "  <section class=\"content ${page_class}\">"
        ${create_content_func} "${page_name}"
        echo "  </section>"
    fi
}

gss_create_common_header() {
    page_name=${1}
    echo "    <span class=\"title\"><a href=\"${SITE_URL:-"/"}\" title=\"${SITE_NAME}\">${SITE_LOGO}</a>&nbsp;›&nbsp;${page_name}</span>"
}

gss_create_simple_page() {
    page_name="${1}"
    page_file_name=${2}
    create_header_func="${3}"
    create_content_func="${4}"
    create_footer_func="${5}"
    create_custom_endpage_func="${6}"

    debug "Generating a page [${page_name}]: ${page_file_name}..."
    mkdir -p "$(dirname "${page_file_name}")"
    gss_begin_page "${page_name}" "${create_header_func}" > "${page_file_name}"
    gss_page_content "${page_name}" "${create_content_func}" >> "${page_file_name}"
    gss_footer_page "${page_name}" "${create_footer_func}" >> "${page_file_name}"
    gss_end_page "${page_name}" "${create_custom_endpage_func}" >> "${page_file_name}"
    debug "Page generated [${page_name}]: ${page_file_name}"
}

if [ "$(basename "${0}")" == "generate-simple-site.sh" ]; then
  #=============================================================================
  # Script entrypoint (the main method)
  #
  create_sample_header() {
    page_name=${1}
    echo "<h1>${page_name}: header</h1>"
  }
  create_sample_content() {
    page_name=${1}
    echo "<h1>Sample renerated page</h1>"
    echo "<p>The page was generated at $(date)</p>"
  }
  create_sample_footer() {
    page_name=${1}
    echo "<p class=\"note\">Page footer</p>"
  }
  create_sample_end_page() {
    page_name=${1}
    echo "  <script type=\"text/javascript\">"
    echo "    console.log('The page ${page_name} loaded.');"
    echo "  </script>"
  }
  gss_load_config
  gss_create_simple_page "SimpleSite" "${OUTPUT_DIR}/index.html" \
    create_sample_header create_sample_content create_sample_footer create_sample_end_page \
  && gss_copy_static_content "https://revgen.github.io/images/emoji/globe-with-meridians.png" \
  && echo "Success" || echo "Failed"
fi
