#!/usr/bin/env node
/** @return {[string, object, string][]} */ function list() { return [
["mep", {
}, `
:root {
    --bg-0: #111;
    --bg-1: #1e1e1e;
    --bg-2: #313131;
    --bg-3: #4d4d4d;

    --co-0: #d4d4d4;
    --co-1: #eee;
    --co-2: #fff;

    --bd-0: #555;
    --bd-1: #727272;

    color-scheme: dark;
}

mark {
    background-color: #8b8b148b !important;
    color: inherit !important;
}
`],


["a - eyesplease", {
}, `
body {
    background: #1e1e1e !important;
}

*:not(a):not(body):not(html) {
    background: rgba(255, 255, 255, .00333) !important;
    border-color: #727272 !important;
    color: #d4d4d4 !important;
}

a {
    color: #1e73be !important;
}
`],


["a - sizeplease", {
}, `
body {
    padding: 0px;
    margin: 0px;
    min-height: 98vh;
}

@media only screen and (min-width: 780px) {
    body {
        padding: 1vh 20vw 1vh 5vw;
    }
}

@media only screen and (min-width: 900px) {
    body {
        padding: 1vh 1vw 1vh 1vw;
    }
}

@media only screen and (min-width: 1200px) {
    body {
        padding: 1vh 25vw 1vh 20vw;
    }
}
`],


["mep - SoundCloud", {
  domains: [
    "soundcloud.com",
  ],
}, `
body {
    background: var(--bg-0);
    color: var(--co-0);
}
body.sc-classic {
    background: var(--bg-0);
    padding-bottom: 49px;
    color: var(--co-0);
}
.l-container.l-content {
    background-color: var(--bg-1);
    color: var(--co-0);
}
@media (max-width: 1239px) {
    .sc-classic .l-container {
        width: calc(100% - 60px);
    }
}

.sc-type-light,
.sc-text {
    color: var(--co-0);
}

.sc-border-light-bottom,
.sc-border-light-right,
.sc-border-light-top,
.sc-classic .mixedSelectionModule,
.sc-classic .l-listen-wrapper .l-about-rows,
.sc-classic .image__whiteOutline .image__full {
    border-color: var(--bd-0);
}

.sc-classic .visualSound.listenContext .visualSound__wrapper {
    background-color: var(--bg-1);
}

.sc-classic .repostOverlay__youReposted {
    color: var(--co-1) !important;
}
.sc-classic .repostOverlay__container,
.sc-classic .audibleEditForm__form,
.sc-classic .gritter-item-wrapper,
.sc-button {
    background-color: var(--bg-2);
    color: var(--co-0);
    border-color: var(--bd-1);
}
.sc-classic .trackItem.active,
.sc-classic .trackItem.hover,
.sc-button-focus,
.sc-button:focus,
.sc-button:hover {
    background-color: var(--bg-3);
    color: var(--co-1);
    border-color: var(--bd-1);
}

.sc-classic .banner.m-alert {
    background-color: #a94545;
}

.sc-input,
.sc-border-light,
.sc-classic .collection.m-overview .collection__section:not(:last-child),
.sc-classic .g-tabs {
    border-color: var(--bd-1);
}

.sc-classic .tileGallery__sliderButton::after {
    border-color: var(--co-0);
}
.sc-button-queue::before,
.sc-button-medium.sc-button-addtoset::before,
.sc-button-medium.sc-button-startstation::before,
.sc-button-report::before,
.sc-classic .paging-eof::before,
:not(.sc-button-selected).sc-button-like::before,
:not(.sc-button-selected).sc-button-repost::before,
.sc-button-share::before,
.sc-button-copylink::before,
:not(.sc-button-active).sc-button-more::before,
.sc-button-medium.sc-button-edit::before,
.sc-button-medium.sc-button-delete::before,
.sc-classic .paging-eof::before {
    filter: invert(.88);
}

.playableTile__actionButton.sc-button,
.playableTile__actionButton.sc-button.sc-button-disabled,
.playableTile__actionButton.sc-button.sc-button-selected,
.playableTile__actionButton.sc-button.sc-button-selected:active,
.playableTile__actionButton.sc-button.sc-button-selected:hover,
.playableTile__actionButton.sc-button:active,
.playableTile__actionButton.sc-button:disabled,
.playableTile__actionButton.sc-button:hover,
.playableTile__actionButton.sc-button:visited {
    background-color: #fff6;
}

.sc-classic .sound__soundActions {
    background-color: var(--bg-1);
}


.sc-classic .dropbar__content,
.sc-classic .dialog {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}

.sc-classic .moreActions,
.sc-classic .moreActions__button,
.sc-classic .moreActions__link,
.sc-classic .moreActions__button:not(:disabled),
.sc-classic .moreActions__link {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}
.sc-classic .moreActions__button:focus:not(:disabled),
.sc-classic .moreActions__button:hover:not(:disabled),
.sc-classic .moreActions__link:hover {
    background-color: var(--bg-3);
}

.sc-classic .trackItem:not(.m-disabled).active .trackItem__additional,
.sc-classic .trackItem:not(.m-disabled).hover .trackItem__additional {
    background: linear-gradient(90deg, #0000, var(--bg-3) 28%);
}
.sc-classic .soundBadge__additional {
    background: linear-gradient(90deg, #0000, var(--bg-1) 28%);
}

.sc-classic .listenEngagement {
    border-color: var(--bg-1);
    box-shadow: 0 1px 0 0 var(--bd-1);
}
.sc-classic .commentForm__wrapper,
.sc-classic .commentForm.m-active .commentForm__wrapper {
    background-color: var(--bg-1) !important;
    border-color: var(--bd-0);
}
.sc-classic .commentForm__input {
    background-color: var(--bg-2) !important;
    color: var(--co-0) !important;
    border-color: var(--bd-0);
}

.commentItem__creatorLink,
.commentItem__username,
.commentItem__usernameLink,
.commentItem__body {
    color: var(--co-0) !important;
}
.commentItem__likeButton {
    background-color: var(--bg-1) !important;
    color: #f50;
}
.commentItem__timestampLink {
    background-color: var(--bg-2) !important;
}
.commentItem__creator,
.commentItem__creatorLink {
    background-color: var(--bg-3);
}
.commentItem__replyButton {
    color: var(--bd-0);
}

.sc-classic .playControls__bg,
.sc-classic .playControls__inner {
    background-color: var(--bg-2);
    color: var(--co-0);
    border-color: var(--bd-1);
}
.sc-classic .playbackTimeline__duration {
    color: inherit;
}
.sc-classic .volume__sliderWrapper {
    background-color: var(--bg-2);
}
.sc-classic .expanded > .volume__sliderWrapper {
    border-color: var(--bd-1) !important;
}
.sc-classic .volume__sliderWrapper::before {
    border-color: transparent transparent var(--bd-1) var(--bd-1);
}
.sc-classic .volume__sliderWrapper::after {
    border-color: transparent transparent var(--bd-1) var(--bd-1);
}
.sc-classic .skipControl__previous,
.sc-classic .skipControl__next,
.sc-classic .playControl,
.sc-classic .shuffleControl::before,
.sc-classic .repeatControl.m-none,
.sc-classic .volume__button,
.sc-classic .sc-button-follow:not(.sc-button-selected).m-boldIcon::before {
    filter: invert(.88);
}
.sc-classic .playbackSoundBadge:not(.m-queueVisible) .playbackSoundBadge__queueIcon {
    fill: var(--co-0);
}

.sc-classic .tokenInput__wrapper,
.sc-classic .queue__panel,
.sc-classic .queueFallback__stationMode {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}
.sc-classic .queue,
.sc-classic .queue__itemsHeight,
.sc-classic .queue__itemWrapper {
    background: var(--bg-1);
}
.sc-classic .queueItemView.m-active,
.sc-classic .queueItemView:hover,
.sc-classic .queueItemView:hover.m-active {
    background-color: var(--bg-3);
}

.sc-classic .header__userNavButton.selected,
.sc-classic .header__userNavItem.selected,
.sc-classic .header__navMenu > li > a.header__moreButton.selected {
    background-color: revert;
}
.sc-classic .headerMenu.m-light,
.sc-classic .dropdownContent__container,
.sc-classic .dropdownContent__header,
.sc-classic .dropdownContent__main,
.sc-classic .dropdownContent__listItem,
.sc-classic .m-light .headerMenu__list {
    border-color: var(--bd-0);
}
.sc-classic .dropdownContent__container,
.sc-classic .m-light .headerMenu__list {
    background-color: var(--bg-2);
}
.sc-classic .m-light .headerMenu__link:focus,
.sc-classic .m-light .headerMenu__link:hover {
    background-color: var(--bg-3);
}
.sc-classic .dropdownContent__header,
.sc-classic .notificationBadge__main,
.sc-classic .m-light .headerMenu__link,
.sc-classic .m-light .headerMenu__link:focus,
.sc-classic .m-light .headerMenu__link:hover {
    color: var(--co-0);
}
.sc-classic .m-light .profileMenu__profile::after,
.sc-classic .m-light .profileMenu__likes::after,
.sc-classic .m-light .profileMenu__sets::after,
.sc-classic .m-light .profileMenu__stations::after,
.sc-classic .m-light .profileMenu__following::after,
.sc-classic .m-light .profileMenu__friends::after,
.sc-classic .m-light .profileMenu__premium::after,
.sc-classic .m-light .profileMenu__trackManager::after,
.sc-classic .m-light .profileMenu__distribute::after {
    filter: invert(.88);
}

.sc-classic .modal.modalWhiteout {
    background: linear-gradient(var(--bg-1), #0000);
}
.sc-classic .tabs__headingContainer,
.sc-classic .tabs__tabs {
    background-color: var(--bg-2);
}
.sc-classic .g-tabs-link,
.sc-classic .g-tabs-link:visited,
.sc-classic .g-tabs-link:focus,
.sc-classic .g-tabs-link:hover {
    color: var(--co-1);
}
.sc-classic .l-fixed-top-one-column > .l-top,
.sc-classic .tagInput__wrapper,
.sc-classic .g-modal-section {
    background-color: var(--bg-1);
}

.sc-classic .modal__modal,
.sc-background-light,
.sc-classic .linkMenu,
.sc-checkbox-check {
    background-color: var(--bg-2);
}

.sc-classic .readMoreTile__countWrapper {
    background-color: var(--bg-0);
}

.sc-classic .truncatedAudioInfo.m-overflow.m-collapsed .truncatedAudioInfo__wrapper::after,
.sc-classic .truncatedUserDescription.m-overflow.m-collapsed .truncatedUserDescription__wrapper::after {
    background: linear-gradient(#0000, var(--bg-1) 90%, var(--bg-0));
}

.sc-classic .compactTrackListItem__number, .sc-classic .compactTrackListItem__trackTitle,
.sc-classic .compactTrackListItem__content {
    color: inherit;
}

.sc-classic .compactTrackListItem.clickToPlay.active, .sc-classic .compactTrackListItem.clickToPlay:focus, .sc-classic .compactTrackListItem.clickToPlay:hover,
.sc-classic .compactTrackListItem.clickToPlay.active .compactTrackListItem__additional, .sc-classic .compactTrackListItem.clickToPlay:focus .compactTrackListItem__additional, .sc-classic .compactTrackListItem.clickToPlay:hover .compactTrackListItem__additional {
    background: var(--bg-3);
}

.artistShortcutTile__username {
    color: var(--co-1);
}

input.headerSearch__input,
input.shareLink__field,
input.shareLink__fromField,
input.textfield__input,
input.tagInput__input {
    background-color: var(--bg-3) !important;
    color: var(--co-0) !important;
}

.sc-classic .searchTitle {
    background-color: unset;
}
.sc-classic .searchTitle__text {
    border-color: var(--bd-1);
}

a.sc-link-dark,
.sc-buylink,
.sc-buylink:visited {
    color: var(--co-0);
}
a.sc-link-dark:hover,
a.sc-link-medium:hover,
a.sc-link-light:hover,
a.sc-ministats:hover,
.sc-buylink:hover {
    font-weight: normal;
    color: var(--co-2);
}
`],


["mep - BitBucket", {
  domains: [
    "bitbucket.org",
  ],
}, `
*:not([role=img]):not(a):not(code):not(span):not(button):not(svg) {
    background: #1e1e1e!important;
    color: #d4d4d4!important;
    border-color: #727272!important;
}

h1,
h2,
h3,
h4,
h5 {
    color: #4C90FF!important;
}

a {
    color: #0052cc!important;
}

code {
    background: #11100d!important;
}

button[type="button"], button {
    background: #313131!important;
    color: #8fa0bc!important;
    border-color: #727272!important;
}

span[role="presentation"] > svg {
    background: #0000
}

/*div[role=alert],
div[role=alert] *,
.sidebar-expander-panel-heading,
.sidebar-expander-panel-heading *,
.rah-static,
.rah-static * {
    background: #2a2a2a!important;
}*/

/*button[type=button],
button[type=button] *,
div[data-qa="create-pull-request-button"] * {
    background: #313131!important;
    color: #a0a0a0!important;
}*/

.ak-navigation-resize-button {
    visibility: hidden;
}

div[data-testid="ContextualNavigation"] *:not([role=img]):not([style^="position: absolute"]) {
    background: #424242!important;
}

div[data-testid="GlobalNavigation"] *:not([role=img]) {
    background: #172B4D!important;
}

div[class$=container] div[class$=control] {
    border-style: none;
}

span[style^="position: absolute"] {
    background: #0000!important;
}
`],


["mep - Heroku", {
  domains: [
    "heroku.com",
  ],
}, `
* {
    background: #1e1e1e!important;
    color: #d4d4d4!important;
    border-color: #727272!important;
}

h1,
h2,
h3,
h4,
h5,
.section-title {
    color: #C18EFF!important;
}

.purple-box * {
    background: #2a2a2a!important;
}

.hk-button-sm--primary {
    background: #79589f!important;
}

.hk-button-sm--secondary {
    background: #313131!important;
    border: 1px solid #79589f!important;
    color: #C18EFF!important;
}

.top-nav,
.top-nav * {
    background: #333!important
}

.deploy-section .pipeline-status::before {
    background: #1e1e1e!important;
}

#overview-page .app-overview-metrics timeseries-chart::after {
    background-image: linear-gradient(to right, #1e1e1e, #0000)!important;
}
`],


["mep - Wikipedia", {
  domains: [
    "esolangs.org",
    "www.pokepedia.fr",
    "wiki.mhcomm.fr",
  ],
  regexps: [
    "https://.*\\.(wiktionary|wikimedia|wikibooks|mediawiki).org/.*",
    "https://wiki\\.[\\w-]+\\.(org|net|fr)/.*",
    "https://[\\w-]+\\.wiki/.*",
    "https://.+/wiki/.*",
  ],
}, `
#mw-head,
.mw-page-container,
body, .sub-header {
    background: var(--bg-0) !important;
    color: var(--co-0) !important;
}

:root {
    --background-color-base: var(--bg-2);
    --color-base: var(--co-1);
    --border-color-base: var(--bd-1);
    --background-color-neutral-subtle: var(--bg-2);
    --background-color-interactive-subtle: var(--bg-2);
    --border-color-subtle: var(--bd-1);
}

@media only screen and (min-width: 1700px) {
    body.skin-vector-legacy #bodyContent/*,
    div#bodyContent*/ {
        margin-left: calc(42vw - 512px);
        margin-right: calc(50vw - 512px);
        width: unset;
    }
    #toc.toc {
        position: absolute;
        top: 30px;
        left: calc(512px - 42vw);
        max-width: calc(42vw - 512px - 3em);
    }
    table.sidebar,
    table.infobox,
    table.infobox_v2 {
        position: absolute;
        top: 0;
        left: calc(42vw + 512px / 2);
    }
    table.sidebar {
        top: calc(30px - 0.5em);
    }
}

.masthead {
    background: var(--bg-2);
}
.navbar-light .navbar-nav .nav-link {
    color: var(--co-1);
}
.vector-header-container .mw-header {
    background-color: unset;
}

/* f- tables with inline style */
table[style][border],
table[style*='border'] {
    background-color: var(--bg-2) !important;
    border-color: var(--bd-1) !important;
}
table[style][border] th,
table[style][border] td,
table[style*='border'] th,
table[style*='border'] td {
    border-color: var(--bd-1);
}
table.wikitable>tbody>tr>td[style*='background'] {
    background-color: var(--bg-3) !important;
}
/*-*/

.mw-logo-container,
.mw-wiki-logo,
#p-logo {
    filter: invert(.72);
}

#mw-page-base {
    background: none;
}

/*a>img { filter: invert(1); }*/

figure[typeof~="mw:File/Thumb"],
figure[typeof~="mw:File/Frame"],
figure[typeof~="mw:File/Thumb"]>figcaption,
figure[typeof~="mw:File/Frame"]>figcaption {
    background-color: var(--bg-3);
    border-color: var(--bd-0);
}

.vector-main-menu,
#content {
    background-color: var(--bg-1);
    color: var(--co-0);
    border-color: var(--bd-0);
}
.skin-vector:not(.skin-vector-legacy) #content {
    border-right: 20px solid var(--bg-1);
    border-left: 20px solid var(--bg-1);
}

/* modern one */
.vector-feature-zebra-design-enabled body,
.vector-feature-zebra-design-enabled .mw-page-container,
.vector-feature-zebra-design-disabled body,
.vector-feature-zebra-design-disabled .mw-page-container {
    background: var(--bg-0);
    color: var(--co-0);
}
.vector-feature-zebra-design-enabled .vector-header-container,
.vector-feature-zebra-design-disabled .vector-header-container,
.vector-feature-zebra-design-enabled .vector-header-container .mw-header,
.vector-feature-zebra-design-disabled .vector-header-container .mw-header,
.vector-feature-zebra-design-enabled .vector-header-container .vector-sticky-header,
.vector-feature-zebra-design-disabled .vector-header-container .vector-sticky-header {
    background: var(--bg-2);
    color: var(--co-0);
}
.vector-feature-zebra-design-disabled .vector-sticky-header-container {
    border-color: var(--bd-1);
}

.vector-feature-zebra-design-enabled .vector-pinned-container,
.vector-feature-zebra-design-disabled .vector-pinned-container,
.vector-feature-page-tools-enabled .vector-main-menu,
.vector-feature-page-tools-disabled .vector-main-menu,
.vector-feature-zebra-design-enabled #vector-main-menu-pinned-container .vector-main-menu,
.vector-feature-zebra-design-disabled #vector-main-menu-pinned-container .vector-main-menu,
.vector-feature-zebra-design-enabled .vector-toc,
.vector-feature-zebra-design-disabled .vector-toc,
.vector-toc {
    background-color: var(--bg-2);
}
.vector-feature-zebra-design-enabled .vector-sticky-pinned-container::after,
.vector-feature-zebra-design-disabled .vector-sticky-pinned-container::after,
.vector-feature-zebra-design-enabled #vector-toc-pinned-container .vector-toc::after,
.vector-feature-zebra-design-disabled #vector-toc-pinned-container .vector-toc::after,
.vector-toc-pinned #vector-toc-pinned-container .vector-toc::after {
    background: linear-gradient(transparent, var(--bg-0));
}
.vector-sticky-pinned-container::after,
.vector-feature-zebra-design-enabled #vector-page-tools-pinned-container .vector-page-tools::after,
.vector-feature-zebra-design-disabled #vector-page-tools-pinned-container .vector-page-tools::after {
    background: linear-gradient(transparent, var(--bg-1));
}

.vector-feature-page-tools-enabled .vector-main-menu-group .vector-menu-heading,
.vector-feature-page-tools-enabled .vector-main-menu-action-item .vector-menu-heading,
.vector-feature-page-tools-disabled .vector-main-menu-group .vector-menu-heading,
.vector-feature-page-tools-disabled .vector-main-menu-action-item .vector-menu-heading,
#mw-footer, .sub-header, .nav-tabs {
    border-color: var(--bd-1);
}

main.mw-body, .bodycontent {
    background-color: var(--bg-1);
}
.vector-toc-not-collapsed .sidebar-toc::after {
    background: linear-gradient(transparent, var(--bg-1));
}
/*-*/

.flow-topic-titlebar {
    background-color: var(--bg-2);
}

.tocnumber {
    color: var(--co-1);
}
#uls-settings-block {
    border: unset;
}

h1, h2, h3, h4, h5, h6 {
    color: var(--co-1) !important;
    border-color: var(--bd-1);
}
hr {
    background-color: var(--bd-1);
}
ul {
    list-style-image: unset;
}
a {
    color: #1c82ba;
}

.vector-user-menu-login,
.mw-article-toolbar-container,
.mw-footer,
.mw-parser-output .hatnote,
.mw-parser-output .dmbox {
    border-color: var(--bd-1);
}
.vector-page-titlebar {
    box-shadow: 0 1px var(--bd-1);
}
.vector-page-toolbar-container {
    box-shadow: 0 1px var(--bd-0);
}

.vector-menu-dropdown .vector-menu-content,
.vector-dropdown .vector-dropdown-content,
.mw-parser-output .side-box,
.infobox,
.infobox_v2,
.cnotice, .cnotice-message p,
div.thumbinner,
.sister-wikipedia, .sister-project,
.derivedterms, .inflection-table,
.homonymie,
.catlinks,
.bandeau-niveau-detail, .bandeau-section.bandeau-niveau-information,
.mw-ui-button,
.mw-sidebar,
.mw-parser-output .sidebar,
.mw-parser-output .quotebox,
.mw-dismissable-notice>.mw-dismissable-notice-body>div>.anonnotice>div,
.toc, .toccolours,
.side-list-contents {
    background-color: var(--bg-2) !important;
    color: var(--co-0) !important;
    border-color: var(--bd-1) !important;
}

.mw-message-box {
    background-color: var(--bg-2);
    color: var(--co-0);
    border-color: var(--bd-1);
}
.mw-message-box-error {
    background-color: #542523;
    color: var(--co-0);
    border-color: #b32424;
}
.mw-message-box-warning {
    background-color: #563d0d;
    color: var(--co-0);
    border-color: #ac6600;
}
.mw-message-box-success {
    background-color: #074336;
    color: var(--co-0);
    border-color: #096450;
}

.NavToggle,
.sidebar-title,
.sidebar-heading,
.infobox tbody th,
.infobox_v2 tbody th,
.infobox-header {
    background-color: var(--bg-3) !important;
}

.wikitable {
    background-color: var(--bg-2);
    color: var(--co-1);
}
.cx-uls-relevant-languages-banner,
.mw-pt-languages,
.mw-parser-output .video-game-reviews caption, .mw-parser-output .vgr-hrow th,
.wikitable > tr > th, .wikitable > * > tr > th {
    background-color: var(--bg-3) !important;
    color: var(--co-2);
    border-color: var(--bd-0);
}
.mw-parser-output .video-game-reviews td, .mw-parser-output .video-game-reviews th, .mw-parser-output .video-game-reviews caption, .mw-parser-output .video-game-reviews table,
.wikitable > tr > th, .wikitable > tr > td, .wikitable > * > tr > th, .wikitable > * > tr > td {
    border-color: var(--bd-1);
}
.wikitable > tbody > tr {
    background-color: var(--bg-2) !important;
}

div.Boxmerge, div.NavFrame, details.NavFrame {
    border-color: var(--bd-1);
}
div.NavFrame div.NavHead, details.NavFrame summary.NavHead {
    background: var(--bg-3) !important;
}
div.NavFrame div.NavHead:hover, details.NavFrame summary.NavHead:hover {
    background: var(--bg-3);
    filter: brightness(1.2);
}
div.NavFrame div.NavContent table *, details.NavFrame summary.NavContent table * {
    background: var(--bg-2) !important;
    border-color: var(--bd-1);
}
.mwe-math-fallback-image-display {
    filter: invert(.765);
}

/* random banners */
.cbnnr, .cbnnr-main {
    background-color: var(--bg-3);
    border: none;
}
/*-*/

/* topnav */
.skin-vector-legacy .vector-menu-tabs,
.skin-vector-legacy .vector-menu-tabs a,
.skin-vector-legacy #mw-head .vector-menu-dropdown .vector-menu-heading,
div.vectorTabs {
    background-image: linear-gradient(to bottom, transparent 32%, var(--bd-0));
}
.vector-menu-tabs-legacy li,
div.vectorTabs ul li {
    background: var(--bg-2);
}
.vector-menu-tabs-legacy .selected,
div.vectorTabs li.selected {
    background: var(--bg-1);
}
.vector-menu-tabs .mw-list-item.selected a, .vector-menu-tabs .mw-list-item.selected a:visited,
.vector-menu-tabs-legacy .selected a, .vector-menu-tabs-legacy .selected a:visited,
div.vectorTabs li.selected a, div.vectorTabs li.selected a:visited {
    color: var(--co-0);
}
/*-*/

/* stick top */
.vector-sticky-header {
    background-color: var(--bg-2);
    color: var(--co-1);
    border-color: var(--bd-1);
}
.vector-sticky-header-context-bar {
    border-color: var(--bd-1);
}
/*-*/

/* sidenav */
.skin-vector-legacy .vector-menu-portal .vector-menu-heading {
    background-image: linear-gradient(to right, transparent, var(--bd-1) 33%, var(--bd-1) 66%, transparent 100%);
}
.skin-vector .vector-menu-portal .vector-menu-heading {
    border-color: var(--bd-1);
}
.sidebar-toc {
    background-color: var(--bg-1);
    color: var(--co-0);
    border-color: var(--bd-0);
}
.vector-feature-page-tools-enabled.vector-toc-pinned .sidebar-toc::after, .vector-feature-page-tools-disabled.vector-toc-not-collapsed .sidebar-toc::after {
    background-image: linear-gradient(transparent, var(--bg-1));
}
.sidebar-toc .sidebar-toc-list-item-active > .sidebar-toc-link, .sidebar-toc .sidebar-toc-level-1-active:not(.sidebar-toc-list-item-expanded) > .sidebar-toc-link, .sidebar-toc .sidebar-toc-list-item-active.sidebar-toc-level-1-active > .sidebar-toc-link,
.sidebar-toc .sidebar-toc-level-1-active:not(.sidebar-toc-list-item-active) > .sidebar-toc-link {
    color: var(--co-0);
}
/*-*/

/* hover popups */
.mwe-popups {
    background-color: var(--bg-1) !important;
    border-radius: 0px;
}
.mwe-popups .mwe-popups-container, .mwe-popups .mwe-popups-extract {
    background-color: var(--bg-2) !important;
    color: var(--co-1);
}
.mwe-popups .mwe-popups-extract[dir='ltr']:after, .mwe-popups .mwe-popups-extract[dir='rtl']:after {
    left: 0;
    background-image: unset;
}
.mwe-popups .mwe-popups-settings-icon:hover {
    background-color: var(--bg-2);
}
.mwe-popups .mwe-popups-settings-icon:active {
    background-color: var(--bg-1);
}
/*-*/

/* choose tl */
.uls-search,
.uls-filtersuggestion,
.uls-menu .uls-no-results-view .uls-no-found-more,
.uls-lcd {
    background-color: var(--bg-2);
}
.uls-languagefilter {
    color: var(--co-1);
}
.uls-no-found-more,
.skin-vector .uls-search,
.skin-vector .uls-menu {
    border-color: var(--bd-1);
}
.uls-language-block > ul > li:hover {
    background-color: var(--bg-1);
}
/*-*/

/* footer table */
.mw-parser-output .navbox, .mw-parser-output .navbox-subgroup,
.mw-parser-output .navbox-even {
    background-color: var(--bg-0);
}
.mw-parser-output .navbox-subgroup .navbox-group, .mw-parser-output .navbox-subgroup .navbox-abovebelow {
    background-color: var(--bg-1);
}
.mw-parser-output .navbox-abovebelow, .mw-parser-output .navbox-group, .mw-parser-output .navbox-subgroup .navbox-title {
    background-color: var(--bg-2);
}
.mw-parser-output .navbox-title {
    background-color: var(--bg-3);
}
.mw-parser-output tr + tr > .navbox-abovebelow, .mw-parser-output tr + tr > .navbox-group, .mw-parser-output tr + tr > .navbox-image, .mw-parser-output tr + tr > .navbox-list,
.mw-parser-output .navbox-list {
    border-color: var(--bd-0);
}
.mw-parser-output .navbox,
.catlinks li {
    border-color: var(--bd-1);
}
.mw-parser-output .portal-bar-bordered,
#bandeau-portail, #liste-portail {
    background-color: var(--bd-1);
    border-color: var(--bd-1);
}
/*-*/

/* user preferences */
#mw-prefs-form {
    background-color: var(--bg-2);
}
.mw-prefs-tabs-wrapper.oo-ui-panelLayout-framed, .mw-prefs-tabs > .oo-ui-menuLayout-content > .oo-ui-indexLayout-stackLayout > .oo-ui-tabPanelLayout,
.mw-prefs-buttons,
.mw-editfont-monospace {
    border-color: var(--bd-1);
}
.oo-ui-tabSelectWidget-framed {
    background-color: var(--bg-3);
}
.mw-prefs-buttons {
    background-color: var(--bg-1);
}
.oo-ui-tabOptionWidget {
    color: var(--co-1);
}
.oo-ui-checkboxInputWidget [type="checkbox"] + span,
.oo-ui-dropdownWidget.oo-ui-widget-enabled .oo-ui-dropdownWidget-handle,
.oo-ui-textInputWidget.oo-ui-widget-enabled .oo-ui-inputWidget-input,
.oo-ui-buttonElement-framed.oo-ui-widget-enabled > .oo-ui-buttonElement-button {
    background-color: var(--bg-3);
    color: var(--co-0);
    border-color: var(--bd-1);
}
.editOptions {
    background-color: var(--bg-2);
    color: var(--co-2);
    border-color: var(--bd-1);
}
/*-*/

.fmbox {
    background-color: #458164 !important;
}
.mw-parser-output .ambox,
.fmbox-warning {
    background-color: #391717 !important;
    border-color: #94560b;
}
.mw-parser-output .pathnavbox {
    background-color: #2d2d30;
    border-color: #3a3a3d;
}
.mw-content-ltr.mw-highlight-lines pre, .mw-content-ltr.content .mw-highlight-lines pre {
    box-shadow: none;
}

.mwe-math-fallback-image-inline {
    filter: invert(.88);
}

.diff-context {
    background-color: var(--bg-2);
    color: var(--co-2);
    border-color: var(--bd-0);
}
.diff-addedline .diffchange,
.diff-deletedline .diffchange {
    color: var(--bg-0);
}

/* code and such */
pre, code, .mw-code, div.mw-geshi, .tpl-code, .tpl-enum, .tpl-param {
    background-color: #272822;
    color: #f8f8f2;
    border-color: #37373d;
}
.mw-parser-output .keyboard-key {
    background-color: #272822;
    background-image: linear-gradient(to bottom,#333,#272822,#333);
    color: #f8f8f2;
    border-color: #444;
    box-shadow: none;
}

/* Monokai (@thx https://help.fandom.com/wiki/Extension:SyntaxHighlight/Styling) */
.mw-highlight .hll { background-color: #49483e }
.mw-highlight, .mw-highlight pre, code.mw-highlight, div.mw-highlight { background: #272822; color: #f8f8f2 }
.mw-highlight .c { color: #75715e }
.mw-highlight .err { color: #960050; background-color: #1e0010 }
.mw-highlight .k { color: #66d9ef }
.mw-highlight .l { color: #ae81ff }
.mw-highlight .n { color: #f8f8f2 }
.mw-highlight .o { color: #f92672 }
.mw-highlight .p { color: #f8f8f2 }
.mw-highlight .ch { color: #75715e }
.mw-highlight .cm { color: #75715e }
.mw-highlight .cp { color: #75715e }
.mw-highlight .cpf { color: #75715e }
.mw-highlight .c1 { color: #75715e }
.mw-highlight .cs { color: #75715e }
.mw-highlight .gd { color: #f92672 }
.mw-highlight .ge { font-style: italic }
.mw-highlight .gi { color: #a6e22e }
.mw-highlight .gs { font-weight: bold }
.mw-highlight .gu { color: #75715e }
.mw-highlight .kc { color: #66d9ef }
.mw-highlight .kd { color: #66d9ef }
.mw-highlight .kn { color: #f92672 }
.mw-highlight .kp { color: #66d9ef }
.mw-highlight .kr { color: #66d9ef }
.mw-highlight .kt { color: #66d9ef }
.mw-highlight .ld { color: #e6db74 }
.mw-highlight .m { color: #ae81ff }
.mw-highlight .s { color: #e6db74 }
.mw-highlight .na { color: #a6e22e }
.mw-highlight .nb { color: #f8f8f2 }
.mw-highlight .nc { color: #a6e22e }
.mw-highlight .no { color: #66d9ef }
.mw-highlight .nd { color: #a6e22e }
.mw-highlight .ni { color: #f8f8f2 }
.mw-highlight .ne { color: #a6e22e }
.mw-highlight .nf { color: #a6e22e }
.mw-highlight .nl { color: #f8f8f2 }
.mw-highlight .nn { color: #f8f8f2 }
.mw-highlight .nx { color: #a6e22e }
.mw-highlight .py { color: #f8f8f2 }
.mw-highlight .nt { color: #f92672 }
.mw-highlight .nv { color: #f8f8f2 }
.mw-highlight .ow { color: #f92672 }
.mw-highlight .w { color: #f8f8f2 }
.mw-highlight .mb { color: #ae81ff }
.mw-highlight .mf { color: #ae81ff }
.mw-highlight .mh { color: #ae81ff }
.mw-highlight .mi { color: #ae81ff }
.mw-highlight .mo { color: #ae81ff }
.mw-highlight .sa { color: #e6db74 }
.mw-highlight .sb { color: #e6db74 }
.mw-highlight .sc { color: #e6db74 }
.mw-highlight .dl { color: #e6db74 }
.mw-highlight .sd { color: #e6db74 }
.mw-highlight .s2 { color: #e6db74 }
.mw-highlight .se { color: #ae81ff }
.mw-highlight .sh { color: #e6db74 }
.mw-highlight .si { color: #e6db74 }
.mw-highlight .sx { color: #e6db74 }
.mw-highlight .sr { color: #e6db74 }
.mw-highlight .s1 { color: #e6db74 }
.mw-highlight .ss { color: #e6db74 }
.mw-highlight .bp { color: #f8f8f2 }
.mw-highlight .fm { color: #a6e22e }
.mw-highlight .vc { color: #f8f8f2 }
.mw-highlight .vg { color: #f8f8f2 }
.mw-highlight .vi { color: #f8f8f2 }
.mw-highlight .vm { color: #f8f8f2 }
.mw-highlight .il { color: #ae81ff }
`],


["mep - MyAnimeList", {
  domains: [
    "myanimelist.net",
  ],
}, `
body,
.page-common #headerSmall,
.page-common #contentWrapper {
    background: var(--bg-0) !important;
    color: var(--co-0) !important;
}

.page-common #horiznav_nav ul li {
    background-color: var(--bg-1);
}
.page-common #horiznav_nav ul li a,
.page-common .header-profile.link-bg {
    background-color: #ffffff09;
}

.user-status-block .form-user-score,
.user-status-block .form-user-episode,
.user-status-block .form-user-episode input[type=text],
.user-status-block .form-user-episode.completed input[type=text],
.user-profile .user-compatability-graph .bar-outer,
.user-profile .user-function .icon-user-function,
.seasonal-anime-list .seasonal-anime,
.seasonal-anime-list .seasonal-anime .prodsrc,
.seasonal-anime-list .seasonal-anime .genres,
.seasonal-anime-list .seasonal-anime .information {
    background-color: var(--bg-2) !important;
    border-color: var(--bd-0) !important;
    color: var(--co-0);
}

.page-common .header-list .header-list-dropdown ul li a,
.page-common .header-profile .header-profile-dropdown ul li a,
.page-forum .forum_boardrow1 {
    background-color: var(--bg-1);
    color: var(--co-0);
}

.page-forum .forum_boardrow2 {
    background-color: #ffffff09;
}

.total_messages,
.page-common .dark_text,
.page-common .dark_text:hover,
.page-common .dark_text:visited {
    color: #888;
}

.page-common .h1 {
    background-color: #19294d;
    border-color: var(--bd-0) !important;
    color: var(--co-0);
}

.widget-header,
.page-common h2 {
    color: var(--co-1) !important;
}

.page-common .header-notification-view-all a,
.page-common .header-notification-dropdown .arrow_box {
    background-color: var(--bd-0);
}
body.notification .notificaiton-category-nav a .counter.zero,
.page-common .header-notification-item {
    background-color: var(--bg-1);
    border-color: var(--bd-0);
}
.page-common .header-profile .header-profile-dropdown ul li a:hover,
.page-common .header-list .header-list-dropdown ul li a:hover,
body.notification .notificaiton-category-nav a.active,
body.notification .notificaiton-category-nav a:hover,
body.notification .notification-item:hover,
.page-common .header-notification-view-all a:hover,
.page-common .header-notification-item:hover {
    background-color: var(--bg-3);
}
.page-common .header-notification-dropdown-inner h3 .mark-all {
    color: #608dff;
}

.detail-characters-list .left-column table:nth-of-type(even),
.detail-characters-list .left-right table:nth-of-type(even) {
    background-color: #ffffff09;
}

.anime-detail-header-stats .stats-block,
.anime-detail-header-stats .user-status-block {
    background-color: #ffffff09;
    border: var(--bd-0) 1px solid !important;
}

.anime-detail-header-stats .stats-block .numbers,
.anime-detail-header-stats .stats-block .score,
.anime-detail-header-stats .stats-block .score:after,
.btn-detail-recommendations-view-all .text {
    color: #ffffffc8;
}

.anime-detail-header-stats .stats-block:before,
.btn-detail-recommendations-view-all,
.page-common .bg-color-base5 {
    background-color: var(--bd-0);
}

.oped-video-button, .oped-preview-button {
    filter: invert(.6) !important;
}

.page-common #content {
    background-color: var(--bg-1) !important;
    border: var(--bd-0) 1px solid !important;
}

body.notification .notificaiton-category-nav li,
body.notification .notification-item,
body.notification .notification-header h3,
body.index .left-column,
body.index .widget-container .widget .widget-header,
.news-list .comment-list,
.news-list .news-unit,
.item,
.review-element .thumbbody,
.page-common h2, .page-common .border_top, .page-common .borderClass,
.page-common .borderDark,
.detail-characters-list .left-column.divider:after,
.spaceit.textReadability.word-break.pt8.mt8,
.page-forum .forum_boardrow1, .page-forum .forum_boardrow2 {
    border-color: var(--bd-0) !important;
}

.page-common div.picSurround img {
    background-color: var(--bg-0);
    border: 1px solid var(--bd-0);
}

.page-common .bgColor1,
.user-profile .user-status li,
.profile .user-comments .comment,
.seasonal-anime-list .seasonal-anime .properties .property,
.seasonal-anime-list .seasonal-anime .properties .property:nth-child(even) {
    background-color: var(--bg-3);
}

.page-common .bgColor2,
.user-profile .user-status li:nth-of-type(even),
.profile .user-comments .comment:nth-of-type(odd) {
    background-color: var(--bg-3);
}

.page-common a.button_add.button_add,
.page-common a.button_add.button_edit,
.page-common a.button_edit.button_add,
.page-common a.button_edit.button_edit,
.ranking-digest .ranking-header {
    background-color: var(--bg-3);
    border-color: var(--bd-0);
}

.ranking-digest,
.widget-slide-block .widget-slide .btn-anime .external-link,
.page-common textarea.textarea {
    background-color: var(--bg-2);
    border-color: var(--bd-0);
}

.page-common .footer-ranking,
.page-common #footer-block {
    background-color: #15264c;
}

.review-element {
    background-color: var(--bg-1);
}
.review-element .thumbbody .body .text {
    color: var(--co-2);
}

.modal-content,
.js-truncate-outer .btn-truncate {
    filter: invert(.867);
}

#fancybox-outer {
    background-color: var(--bg-3);
}
#dialog {
    border-color: var(--bd-1);
}

a {
    color: #608dff !important;
    text-decoration: none;
}
a:hover {
    color: #637ab5 !important;
    text-decoration: underline;
}
a:visited {
    color: #637ab5 !important;
}
`],


["mep - protectedText", {
  domains: [
    "protectedtext.com",
  ],
}, `
#main-content-outter {
    background-color: var(--bg-0);
}

.textarea-contents {
    color: #d4d4d4 !important;
    background-color: var(--bg-1);
    border-color: var(--bd-0) !important;
}

.ui-state-default a, .ui-state-default a:link, .ui-state-default a:visited {
    color: #0645ad;
}

#tabs li, #add_tab {
    background: var(--bg-2);
    border-color: var(--bg-2);
}

#tabs .ui-icon.ui-icon-close {
    filter: brightness(1.33);
}

#tabs li.ui-tabs-active, #tabs li.ui-state-active {
    color: var(--bd-1);
    background-color: var(--bg-3);
    border-color: var(--bd-0);
}

#tabs li.ui-tabs-active a, #add_tab .ui-button-text {
    color: var(--bd-1);
}

button.ui-state-default {
    filter: brightness(0.7);
}

.homepage-hline-darker {
    background-color: hsl(218, 53%, 32%)
}

.homepage-hline-lighter {
    background-color: hsl(218, 53%, 23%);
}

body, #homepage-second-div {
    color: var(--co-0);
    background-color: var(--bg-2);
}

#homepage-second-div h2, #homepage-second-div h3, #content-holder h2, #content-holder h3 {
    color: hsl(207, 93%, 46%);
}

#content-holder {
    color: revert;
}

#content-holder b {
    color: hsl(207, 93%, 38%);
}
`],


["mep - npm", {
  domains: [
    "npmjs.com",
  ],
}, `
body, :root {
    background-color: var(--bg-1);
    color: var(--co-0);
}

header>div {
    background-color: var(--bg-2) !important;
}
header div>a>svg>path {
    fill: var(--co-0);
}
header>div>div>span {
    color: var(--co-0) !important;
}
header nav a {
    color: var(--co-0) !important;
}
header #search>div>div:last-of-type {
    background-color: var(--bg-2) !important;
}
header #search>div>ul * {
    background-color: var(--bg-2) !important;
    border-color: var(--bd-0) !important;
    color: var(--co-0) !important;
}
header #search>div {
    border-color: var(--bd-0);
}
header #search>button, header #search input {
    color: var(--co-0)
}
header div>nav>button {
    background-color: var(--bg-2) !important;
}
header div>nav>span>div {
    background-color: var(--bg-1) !important;
    border-color: var(--bd-0) !important;
}
header div>nav>span>div::before {
    border-bottom-color: var(--bd-0) !important;
}
header div>nav>span>div>h2>span {
    color: var(--co-2) !important;
}
header div>nav>span>div::after {
    border-bottom-color: var(--bg-1) !important;
}
header {
    border-color: var(--bd-0) !important;
}

main {
    background-color: var(--bg-1) !important;
    color: var(--co-0) !important;
}
main h2>span {
    color: var(--co-2);
}
main>div>div>span:first-of-type, main>div>div>span:last-of-type {
    color: var(--co-0);
}
main article p, main article li, main article strong {
    color: var(--co-0) !important;
}
main article h1, main article h2, main article h3, main article h4, main article h5, main article h6 {
    color: var(--co-2) !important;
    border-color: var(--bd-0) !important;
}
main section>div>h2 {
    color: var(--co-2) !important;
}
main article code, main article pre {
    background-color: var(--bg-1) !important;
    color: var(--co-2);
    border-color: var(--bd-3);
}
main article blockquote {
    background-color: var(--bd-3) !important;
    border-color: var(--bd-1) !important;
}

main div>div>p, main div>div>p>a, main div>div>p>a>span>svg>g {
    color: var(--co-0) !important;
    fill: var(--co-0);
}
/*main div>div>p:has(code):hover {
    background-color: hsl(120, 100%, 12%) !important;
}*/
main div>div>p>svg {
    fill: var(--bd-0) !important;
}
main div>div>p>code>span {
    border-color: var(--bd-0) !important;
}
main div>div>h3>svg {
    fill: var(--bd-0) !important;
}

main>div, main>div>div {
    background-color: var(--bg-1) !important;
    color: var(--co-0) !important;
}
main>div>div {
    border-color: var(--bg-2) !important;
}
main div>div>div>h2 {
    color: var(--co-2) !important;
}
main div>div>div>h3 {
    color: var(--co-0) !important;
}
main>div>div>div>div>ul>li>a {
    background-color: var(--bg-1) !important;
    border-color: var(--bg-2) !important;
    color: var(--co-0) !important;
}
main>div>div>div>ul>li>section {
    border-color: var(--bg-2) !important;
}
main>div>div>div>ul>li>section * {
    color: var(--co-0) !important;
}
main>div>div>div>ul>li>section h3 {
    color: var(--co-2) !important;
}

main>div>div>div>div>ul>li>section {
    border-color: var(--bg-2) !important;
}
main>div>div>div>div>ul>li>section * {
    color: var(--co-0) !important;
}
main>div>div>div>div>ul>li>section h3 {
    color: var(--co-2) !important;
}
main div>div>div>h2 span {
    color: var(--co-2) !important;
}

main>div>div>span>#tabpanel-versions h3,
main>div>div>span>section>h2 {
    color: var(--co-2) !important;
}
main>div>div>span>#tabpanel-versions span,
main>div>div>span>#tabpanel-versions code,
main>div>div>span>#tabpanel-versions a {
    color: var(--co-0) !important;
}

main>div>div>section h3 {
    color: var(--co-2) !important;
}
main>div>div>section p {
    color: var(--co-0) !important;
}
main>div>div>section div a {
    color: var(--co-0) !important;
}
main>div>div>section div span {
    color: var(--bd-0) !important;
}

main>div>div>div>nav>div>a {
    background-color: var(--bg-2) !important;
    border-color: var(--bd-0) !important;
}
main aside p, main aside b {
    color: var(--co-0) !important
}

footer {
    background-color: var(--bg-2);
    color: var(--co-0);
}
footer #footer {
    background-color: var(--bg-2);
    color: var(--co-0);
}
footer div>h3 {
    color: var(--co-0) !important;
}
footer ul>li>a {
    color: var(--co-0) !important;
}

.markdown .keyword,
.markdown .storage,
.markdown .storage.type {
    color: #0366d6;
}

.markdown table {
    border: 0px !important;
}
.markdown td, .markdown th {
    border: 0px;
    background-color: var(--bg-1);
    color: var(--co-0);
}
.markdown tr:nth-child(2n) td {
    background-color: var(--bg-2);
}

/*!
 * GitHub Dark v0.5.0
 * Copyright (c) 2012 - 2017 GitHub, Inc.
 * Licensed under MIT (https://github.com/primer/github-syntax-theme-generator/blob/master/LICENSE)
 */

.pl-c /* comment, punctuation.definition.comment, string.comment */ {
  color: #959da5;
}

.pl-c1 /* constant, entity.name.constant, variable.other.constant, variable.language, support, meta.property-name, support.constant, support.variable, meta.module-reference, markup.quote, markup.raw, meta.diff.header */,
.pl-s .pl-v /* string variable */ {
  color: #c8e1ff;
}

.pl-e /* entity */,
.pl-en /* entity.name */ {
  color: #b392f0;
}

.pl-smi /* variable.parameter.function, storage.modifier.package, storage.modifier.import, storage.type.java, variable.other */,
.pl-s .pl-s1 /* string source */ {
  color: #f6f8fa;
}

.pl-ent /* entity.name.tag */ {
  color: #7bcc72;
}

.pl-k /* keyword, storage, storage.type */ {
  color: #ea4a5a;
}

.pl-s /* string */,
.pl-pds /* punctuation.definition.string, source.regexp, string.regexp.character-class */,
.pl-s .pl-pse .pl-s1 /* string punctuation.section.embedded source */,
.pl-sr /* string.regexp */,
.pl-sr .pl-cce /* string.regexp constant.character.escape */,
.pl-sr .pl-sre /* string.regexp source.ruby.embedded */,
.pl-sr .pl-sra /* string.regexp string.regexp.arbitrary-repitition */ {
  color: #79b8ff;
}

.pl-v /* variable */,
.pl-ml /* markup.list, sublimelinter.mark.warning */ {
  color: #fb8532;
}

.pl-bu /* invalid.broken, invalid.deprecated, invalid.unimplemented, message.error, brackethighlighter.unmatched, sublimelinter.mark.error */ {
  color: #d73a49;
}

.pl-ii /* invalid.illegal */ {
  color: #fafbfc;
  background-color: #d73a49;
}

.pl-c2 /* carriage-return */ {
  color: #fafbfc;
  background-color: #d73a49;
}

.pl-c2::before /* carriage-return */ {
  content: "^M";
}

.pl-sr .pl-cce /* string.regexp constant.character.escape */ {
  font-weight: bold;
  color: #7bcc72;
}

.pl-mh /* markup.heading */,
.pl-mh .pl-en /* markup.heading entity.name */,
.pl-ms /* meta.separator */ {
  font-weight: bold;
  color: #0366d6;
}

.pl-mi /* markup.italic */ {
  font-style: italic;
  color: #f6f8fa;
}

.pl-mb /* markup.bold */ {
  font-weight: bold;
  color: #f6f8fa;
}

.pl-md /* markup.deleted, meta.diff.header.from-file, punctuation.definition.deleted */ {
  color: #b31d28;
  background-color: #ffeef0;
}

.pl-mi1 /* markup.inserted, meta.diff.header.to-file, punctuation.definition.inserted */ {
  color: #176f2c;
  background-color: #f0fff4;
}

.pl-mc /* markup.changed, punctuation.definition.changed */ {
  color: #b08800;
  background-color: #fffdef;
}

.pl-mi2 /* markup.ignored, markup.untracked */ {
  color: #2f363d;
  background-color: #959da5;
}

.pl-mdr /* meta.diff.range */ {
  font-weight: bold;
  color: #b392f0;
}

.pl-mo /* meta.output */ {
  color: #0366d6;
}

.pl-ba /* brackethighlighter.tag, brackethighlighter.curly, brackethighlighter.round, brackethighlighter.square, brackethighlighter.angle, brackethighlighter.quote */ {
  color: #ffeef0;
}

.pl-sg /* sublimelinter.gutter-mark */ {
  color: #6a737d;
}

.pl-corl /* constant.other.reference.link, string.other.link */ {
  text-decoration: underline;
  color: #79b8ff;
}
`],


["mep - docs.npm", {
  domains: [
    "docs.npmjs.com",
  ],
}, `
div[role=navigation] {
    background-color: var(--bg-0);
}
div[role=navigation] * {
    border-color: var(--bd-0);
}
div[role=navigation] a.active {
    color: var(--co-1);
}

h1 {
    color: var(--co-2);
}
div {
    color: var(--co-0) !important;
}

pre, code {
    background-color: var(--bg-2) !important;
    border-color: var(--bd-1) !important;
}
pre .token.operator {
    color: #e90fcc !important;
}
`],


["mep - MDN Web Docs", {
  domains: [
    "developer.mozilla.org",
  ],
}, `
iframe.nobutton,
iframe.sample-code-frame,
iframe[src*="https://jsfiddle.net"],
iframe[src*="https://mdn.github.io"],
iframe[src*="https://test262.report"],
iframe[src*="https://www.youtube-nocookie.com"] {
    background-color: var(--bg-2);
    color: var(--co-1);
    border-color: var(--bd-1);
}
`],


["mep - man7", {
  domains: [
    "man7.org",
  ],
}, `
html, body {
    background-color: var(--bg-1);
    color: var(--co-0);
    border-color: var(--bd-1);
}

body {
    margin-left: calc(50vw - 390.5px);
    margin-right: calc(50vw - 390.5px);
}

a {
    color: #0052cc;
}

b {
    color: #8f3900;
}

i {
    color: #007500;
}

h2 {
    color: #c70000;
}

h3 {
    color: #8a0000;
}

div.nav-bar, div.footer, .listing {
    background-color: var(--bg-2);
}

hr.nav-end, hr.start-footer, hr.end-footer, hr.end-man-text, hr {
    border-color: var(--bd-1);
}
`],


["mep - linux.die.net", {
  domains: [
    "die.net",
  ],
}, `
body {
    background-color: var(--bg-1);
    color: var(--co-0);
    border-color: var(--bd-0);
}

#bg {
    max-width: revert;
}

#content {
    margin-left: 200px;
    overflow-y: hidden;
}
@media only screen and (min-width: 900px) {
    #content {
        margin-left: 25vw;
        padding-right: calc(50vw - 300px);
    }
}

#logo, #menu {
    width: 150px;
    max-width: 180px;
    border-bottom: revert;
    border-right: 2px solid var(--bd-0);
    position: fixed;
}

#logo img {
    margin-left: auto;
    display: block;
}

#menu {
    height: 100vh;
}

#news {
    background-color: var(--bg-2);
}

.gsc-control-cse, .gsc-control-cse * {
    background-color: var(--bg-2) !important;
    border-color: var(--bd-1) !important;
}
.gs-webResult .gs-snippet, .gs-fileFormatType {
    color: #d4d4d4 !important;
}
.gs-result .gs-title *, .gsc-cursor-page, .gs-spelling a {
    color: #ae160c !important;
}
.gs-webResult div.gs-visibleUrl, .gcsc-find-more-on-google {
    color: #86363a;
}

h1, h2 {
    color: #8f0000;
}

a {
/*     color: #ae160c; */
    color: #0052cc;
}

b {
/*     color: #8e2626; */
    color: #8f3900;
}

i {
/*     color: #407b11; */
    color: #007500;
}
`],


["mep - opengroup.org", {
  domains: [
    "pubs.opengroup.org",
  ],
}, `
body {
    font-size: 14pt;
}

body, h1, h2, h3, h4, h5, h6, p, li {
    background-color: var(--bg-1);
}

.nav, div.box, table {
    background-color: var(--bg-2);
}

body, p, li {
    color: var(--co-0);
}

a {
    color: #0052cc !important;
}

hr {
    border-color: var(--bd-0);
}

@media only screen and (min-width: 780px) {
    body {
        padding: 1vh 20vw 1vh 5vw;
    }
}

@media only screen and (min-width: 900px) {
    body {
        padding: 1vh 1vw 1vh 1vw;
    }
}

@media only screen and (min-width: 1200px) {
    body {
        padding: 1vh 25vw 1vh 20vw;
    }
}
`],


["mep - invisible-island", {
  domains: [
    "invisible-island.net",
  ],
}, `
body, h1, h2, h3, h4, h5, h6, p, li {
    background-color: var(--bg-1);
}

@media only screen and (max-width: 1000px) {
    body {
        margin: 1em;
    }
    .nav {
        visibility: hidden;
    }
}
@media only screen and (max-width: 1000px) and (min-width: 719px) {
    body {
        margin-left: calc(50vw - 23em);
    }
}

.nav, .nav *, div.box {
    background-color: var(--bg-2);
}

*.nav-top, *.nav-top *{
    background-color: var(--bd-0);
}

body, p, li {
    color: var(--co-0);
}

a {
    color: #0052cc;
}

hr {
    border-color: var(--bd-0);
}
`],


["mep - lfs", {
  domains: [
    "linuxfromscratch.org",
  ],
}, `
body, * {
    background-color: var(--bg-1);
    color: var(--co-0);
}

h1, h2, h3, h4, h5, h6, b, .strong {
    color: var(--co-1);
}

.book h1, .book .authorgroup, .book .copyright, .book .legalnotice .revhistory,
.preface h2, .part h1, .chapter h2, .appendix h2, .index h1, .sect1 h2,
div.author *, .book .titlepage, .book .titlepage *,
div.navbar, div.navbar *, #leftmenu ul, #leftmenu ul *,
div.navheader ul, div.navfooter ul,
div.navfooter * {
    background-color: var(--bg-2);
}

.preface h2, .part h1, .chapter h2, .appendix h2, .index h1, .sect1 h2,
div.navbar, div.navbar *, #leftmenu ul, #leftmenu ul * {
    border-color: var(--bd-0);
}

.book h2.subtitle, .book hr,
.book h2.subtitle *, .book hr * {
    background-color: #424670;
}

div.navheader, div.navfooter {
    background-color: var(--bd-0);
    border: 0px;
}

pre.userinput, pre.screen, pre code, pre kbd {
    background-color: var(--bg-1);
    color: var(--co-0);
}

div.note, div.tip,
div.note *, div.tip *,
div.important, div.warning, div.caution,
div.important *, div.warning *, div.caution *,
.lfs .package,
.lfs .configuration,
.lfs .content,
.lfs .package *,
.lfs .configuration *,
.lfs .content  * {
    background-color: var(--bg-2);
    border-color: var(--bd-0);
}

a {
    color: #0052cc !important;/**/
}
`],


["mep - stackexchange", {
  domains: [
    "stackexchange.com",
    "stackoverflow.com",
    "superuser.com",
    "askubuntu.com",
    "serverfault.com",
    "mathoverflow.net",
    "stackapps.com",
  ],
}, `
body {
    background: var(--bg-0);
    color: var(--co-0) !important;

    --highlight-color: #98d361 !important;
}

body.floating-content #content,
body.floating-content>.container,
div#content {
    background-color: var(--bg-1);
    border-color: var(--bd-0);
}

h1 a,
.s-label,
.s-topbar .s-navigation .s-navigation--item:not(.is-selected) {
    color: var(--co-1) !important;
}

pre,
code,
pre code,
.left-sidebar--sticky-container, .leftnav-dialog,
.s-topbar .s-navigation .s-navigation--item:not(.is-selected):hover {
    background-color: var(--bg-0) !important;
    color: var(--co-0) !important;
}

select,
input,
textarea,
.wmd-button-bar,
.wmd-button-row,
.s-sidebarwidget,
.s-sidebarwidget *,
aside,
header.s-topbar {
    background-color: var(--bg-2) !important;
    border-color: var(--bd-0) !important;
    color: var(--co-0) !important;
}

.fc-theme-body-font {
    color: inherit !important;
}

.fc-black-500, .h\\:fc-black-500:hover, .f\\:fc-black-500:focus, .f\\:fc-black-500:focus-within {
    color: var(--co-0) !important;
}
.bg-black-050, .h\\:bg-black-050:hover, .f\\:bg-black-050:focus, .f\\:bg-black-050:focus-within {
    background-color: var(--bg-2) !important;
}
.bc-black-225, .h\\:bc-black-225:hover, .f\\:bc-black-225:focus, .f\\:bc-black-225:focus-within,
.bc-black-200, .h\\:bc-black-200:hover, .f\\:bc-black-200:focus, .f\\:bc-black-200:focus-within {
    border-color: var(--bd-0) !important;
}

.owner {
    background-color: var(--bg-3);
}
.user-info {
    color: var(--co-1);
}

blockquote {
    color: var(--bd-1) !important;
}
.question-page #answers .answer,
.bc-black-2, .bc-black-075,
ul.comments-list .comment > *,
.snippet-code {
    border-color: var(--bd-0) !important;
}

.question-hyperlink, .answer-hyperlink {
    color: var(--bd-1);
}

.post-tag,
.geo-tag,
.container .chosen-choices .search-choice,
.container .chosen-container-multi .chosen-choices li.search-choice,
header.site-header,
footer.site-footer {
    background-color: revert;
    border-color: revert;
}

.show-votes .sidebar-linked .spacer>a:first-child .answer-votes,
.show-votes .sidebar-related .spacer>a:first-child .answer-votes,
.badge-tag,
.s-tag, .s-badge:not(.s-badge__answered) {
    color: var(--co-2);
    background-color: var(--bg-3);
    border-color: var(--bd-1);
}

.s-prose hr {
    background-color: var(--bd-1);
}
.s-table thead th,
.s-table tbody td {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}
.s-card {
    background-color: var(--bg-2);
    border-color: var(--bd-0);
}
.s-prose .spoiler {
    background-color: var(--bg-2);
}
.s-prose .spoiler>* {
    color: var(--co-1);
}
.s-prose blockquote::before {
    background-color: var(--bd-0)
}

.s-btn-group .s-btn.s-btn__outlined,
.s-pagination .s-pagination--item:not(.is-selected) {
    color: var(--co-1);
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}
.s-btn-group .s-btn.is-selected.s-btn__outlined {
    background-color: var(--bg-3);
}

.grippie {
    background-color: var(--bd-0);
}

.js-stacks-editor-container>* {
    border-color: var(--bd-1);
}
.js-stacks-editor-container * {
    background-color: var(--bg-2);
}

.js-consent-banner,
div[data-campaign-name='stk'],
.everyonelovesstackoverflow,
.ai-content-policy-notice,
#onetrust-consent-sdk,
#credential_picker_container {
    display: none;
    visibility: hidden;
    max-width: 0;
    max-height: 0;
    padding: 0 !important;
}

.s-prose a {
    color: #3eb0ff !important;
}
`],


["mep - gnu.org", {
  regexps: [
    "https://\\w+\\.gnu\\.org/.*?(manual|standards|software|onlinedocs)/.*",
  ],
}, `
html {
    background-color: var(--bg-0);
}

body,
#footer {
    background-color: var(--bg-1);
    color: var(--co-0);
    border-color: var(--bd-0);
    box-shadow: none;
}

#categories,
#list-container .category,
#mission-statement {
    background-color: var(--bg-2);
    border-color: var(--bd-0);
}

div.header {
    background-color: var(--bg-2) !important;
    color: var(--co-0);
}

hr {
    border-color: var(--bd-0);
}

h1, h2, h3, h4, h5, h6, dt, code {
    color: var(--co-2);
    background-color: inherit;
}

div.example, pre.example,
div.lisp,
div > pre {
    background-color: var(--bg-2) !important;
    border-color: var(--bd-0);
}

.syntax-symbol,
.syntax-default {
    background-color: var(--bg-2);
    color: #c1448c;
}

.syntax-comment {
    color: var(--co-1);
}

a[href].syntax-symbol {
    background-color: var(--bg-2);
    color: #3c82c8 !important;
}

a {
    color: #0052cc !important;
}

a:visited {
    color: #164182 !important;
}
`],


["mep - gnu.org (sizing for some)", {
  regexps: [
    "https://www\\.gnu\\.org/software/.*/manual/.*html_node.*",
  ],
  urlPrefixes: [
    "https://www.gnu.org/savannah-checkouts/gnu/libc",
    "https://gcc.gnu.org/onlinedocs/",
  ],
}, `
body {
    margin-left: calc(50vw - 390.5px);
    margin-right: calc(50vw - 390.5px);
}
`],


["mep - llvm.org", {
  domains: [
    "llvm.org",
    "llvmpy.org",
  ],
}, `
body {
    background-color: var(--bg-1);
    color: #d4d4d4;
    border-color: var(--bd-0);
}

.doc_code, .literal-block, .rel_boxtext, #menu a {
    background-color: var(--bg-2) !important;
    border-color: var(--bd-0);
}

.doc_title, .doc_section, .doc_subsection,
.www_sectiontitle, .www_subsection, .www_sidebar,
.rel_section {
    filter: invert(.867);
    color: #414141;
    border: solid 1px #959595;
}

div.body h1, div.body h2, div.body h3, div.body h4, div.body h5, div.body h6 {
    background-color: var(--bg-2);
    color: var(--co-1);
    border-color: var(--bd-0);
}
div.body h1 a, div.body h2 a, div.body h3 a, div.body h4 a, div.body h5 a, div.body h6 a {
    color: var(--co-1) !important;
}

div.admonition, div.warning {
    background-color: var(--bg-3);
    color: var(--co-2);
}

img {
    filter: invert(.808);
    background-color: #888;
    border: solid 1px #959595;
}

a {
    color: #608dff !important;
    text-decoration: none;
}

a:hover {
    color: #637ab5 !important;
    text-decoration: underline;
}

a:visited {
    color: #637ab5 !important;
}
`],


["mep - llvm.org (sizing for some)", {
  domains: [
    "releases.llvm.org",
  ],
  urlPrefixes: [
    "https://llvm.org/doxygen",
  ],
}, `
@media (min-width: 1200px) {
    body {
        margin-left: calc(50vw - 380.5px);
        margin-right: calc(50vw - 380.5px);
    }
}
`],


["mep - llvm.org (not sure but stuff)", {
  domains: [
    "llvmpy.org",
  ],
  regexps: [
    "https://.*\\.llvm\\.org/.*",
  ],
  urlPrefixes: [
    "https://llvm.org/docs",
  ],
}, `
html {
    background: var(--bg-0);
}
body {
    background-color: var(--bg-1);
}

div.logo img {
    filter: invert(.937);
    background-color: #fff;
    border: none;
}

div.logo {
    background-color: var(--bg-0);
}

div.document,
div.body {
    background: var(--bg-1);
    color: var(--co-0);
}

div.bottomnav,
div.topnav {
    background-color: var(--bg-2);
}

div.related ul {
    background: var(--bg-3);
    border-color: var(--bd-0);
    overflow: hidden;
}

div.bodywrapper {
    border-color: var(--bd-0);
}

div.footer {
    background-color: var(--bg-0);
}

div.sphinxsidebar h3, div.sphinxsidebar h4 {
    background-color: #3b4c4f;
    color: revert;
}
div.sphinxsidebar ul {
    background-color: var(--bg-1);
}
div.sphinxsidebar li {
    border-color: var(--bd-0);
}
div.sphinxsidebar li:hover {
    background-color: var(--bg-2);
}
div.sphinxsidebar input {
    background-color: var(--bg-2);
    color: var(--co-2);
    border-color: var(--bd-1);
}
div.sphinxsidebar #searchbox input[type="submit"] {
    background-color: var(--bg-3);
}

div.topic, div.highlight > pre {
    background-color: var(--bg-2);
    border-color: var(--bd-0);
}

h1, h2, h3, h4 {
    color: var(--co-1);
    border-color: var(--bd-0);
}

/*! Monokai theme; http://blog.favrik.com/2011/02/22/preview-all-pygments-styles-for-your-code-highlighting-needs/#stylesheetNavigator */
.highlight, .highlight pre, .highlight table, code { background: #272822 !important; color: #e8e8e2 !important; }
.highlight .hll { background-color: #49483e !important; }
.highlight .c { color: #75715e !important; } /* Comment */
.highlight .err { color: #960050 !important; background-color: #1e0010 !important; } /* Error */
.highlight .k { color: #66d9ef !important; } /* Keyword */
.highlight .l { color: #ae81ff !important; } /* Literal */
.highlight .n, .highlight .h { color: #f8f8f2 !important; } /* Name */
.highlight .o { color: #f92672 !important; } /* Operator */
.highlight .p { color: #f8f8f2 !important; } /* Punctuation */
.highlight .cm { color: #75715e !important; } /* Comment.Multiline */
.highlight .cp { color: #75715e !important; } /* Comment.Preproc */
.highlight .c1 { color: #75715e !important; } /* Comment.Single */
.highlight .cs { color: #75715e !important; } /* Comment.Special */
/*.highlight .ge { } /* Generic.Emph */
/*.highlight .gs { } /* Generic.Strong */
.highlight .kc { color: #66d9ef !important; } /* Keyword.Constant */
.highlight .kd { color: #66d9ef !important; } /* Keyword.Declaration */
.highlight .kn { color: #f92672 !important; } /* Keyword.Namespace */
.highlight .kp { color: #66d9ef !important; } /* Keyword.Pseudo */
.highlight .kr { color: #66d9ef !important; } /* Keyword.Reserved */
.highlight .kt { color: #66d9ef !important; } /* Keyword.Type */
.highlight .ld { color: #e6db74 !important; } /* Literal.Date */
.highlight .m { color: #ae81ff !important; } /* Literal.Number */
.highlight .s { color: #e6db74 !important; } /* Literal.String */
.highlight .na { color: #a6e22e !important; } /* Name.Attribute */
.highlight .nb { color: #f8f8f2 !important; } /* Name.Builtin */
.highlight .nc { color: #a6e22e !important; } /* Name.Class */
.highlight .no { color: #66d9ef !important; } /* Name.Constant */
.highlight .nd { color: #a6e22e !important; } /* Name.Decorator */
.highlight .ni { color: #f8f8f2 !important; } /* Name.Entity */
.highlight .ne { color: #a6e22e !important; } /* Name.Exception */
.highlight .nf { color: #a6e22e !important; } /* Name.Function */
.highlight .nl { color: #f8f8f2 !important; } /* Name.Label */
.highlight .nn { color: #f8f8f2 !important; } /* Name.Namespace */
.highlight .nx { color: #a6e22e !important; } /* Name.Other */
.highlight .py { color: #f8f8f2 !important; } /* Name.Property */
.highlight .nt { color: #f92672 !important; } /* Name.Tag */
.highlight .nv { color: #f8f8f2 !important; } /* Name.Variable */
.highlight .ow { color: #f92672 !important; } /* Operator.Word */
.highlight .w { color: #f8f8f2 !important; } /* Text.Whitespace */
.highlight .mf { color: #ae81ff !important; } /* Literal.Number.Float */
.highlight .mh { color: #ae81ff !important; } /* Literal.Number.Hex */
.highlight .mi { color: #ae81ff !important; } /* Literal.Number.Integer */
.highlight .mo { color: #ae81ff !important; } /* Literal.Number.Oct */
.highlight .sb { color: #e6db74 !important; } /* Literal.String.Backtick */
.highlight .sc { color: #e6db74 !important; } /* Literal.String.Char */
.highlight .sd { color: #e6db74 !important; } /* Literal.String.Doc */
.highlight .s2 { color: #e6db74 !important; } /* Literal.String.Double */
.highlight .se { color: #ae81ff !important; } /* Literal.String.Escape */
.highlight .sh { color: #e6db74 !important; } /* Literal.String.Heredoc */
.highlight .si { color: #e6db74 !important; } /* Literal.String.Interpol */
.highlight .sx { color: #e6db74 !important; } /* Literal.String.Other */
.highlight .sr { color: #e6db74 !important; } /* Literal.String.Regex */
.highlight .s1 { color: #e6db74 !important; } /* Literal.String.Single */
.highlight .ss { color: #e6db74 !important; } /* Literal.String.Symbol */
.highlight .bp { color: #f8f8f2 !important; } /* Name.Builtin.Pseudo */
.highlight .vc { color: #f8f8f2 !important; } /* Name.Variable.Class */
.highlight .vg { color: #f8f8f2 !important; } /* Name.Variable.Global */
.highlight .vi { color: #f8f8f2 !important; } /* Name.Variable.Instance */
.highlight .il { color: #ae81ff !important; } /* Literal.Number.Integer.Long */

@media (min-width: 1200px) {
    body {
        margin-left: calc(50vw - 600.5px);
        margin-right: calc(50vw - 600.5px);
    }
}
`],


["mep - Git", {
  domains: [
    "git-scm.com",
    "libgit2.org",
    "git-lfs.com",
  ],
}, `
body {
    background: var(--bg-0);
    color: var(--co-0);
}

#main,
#content-wrapper,
#main .callout {
    background: var(--bg-1);
    border-color: var(--bd-0);
}

@media (min-width: 940px) {
    #documentation .inner,
    #search .inner,
    #home .inner {
        margin-left: calc(48vw - 570.5px);
        margin-right: calc(52vw - 570.5px);
    }
}

#front-content #front-navigation,
#front-book,
#companies-projects,
footer {
    border-color: var(--bd-0);
}

span.highlight {
    background-color: #4d4b12;
}

div > pre, code {
    color: #c49f82 !important;
    background-color: var(--bg-2) !important;
    border-color: var(--bd-0) !important;
}

#masthead {
    color: #4e443c;
    margin-bottom: 0;
    border-bottom: solid var(--bg-1) 2em;
}

footer a,
aside nav ul li a,
#front-nav a {
    color: #0052cc;
}

em {
    color: #42a055 !important;
}
`],


["mep - Git (some extra idk)", {
  domains: [
    "libgit2.org",
  ],
}, `
p, h1, h2, h3, h4, h5, h6 {
    color: var(--co-0);
}

*:not(pre) > code, pre {
    border: solid 1px var(--bd-0);
    border-radius: 3px;
}

pre {
    overflow: auto;
}

#toc {
    background: var(--bg-1);
    border-color: var(--bd-0);
}
`],


["mep - GitLab", {
  domains: [
    "gitlab.com",
    "invent.kde.org",
  ],
  regexps: [
    ".*gitlab\\..*\\.(?:com|org).*",
  ],
}, `
body,
.merge-request-tabs-holder,
.mr-widget-heading,
.mr-section-container,
.mr-version-controls,
.diff-files-changed,
.timeline-entry:not(.system-note) {
    background-color: var(--bg-1);
    color: var(--co-0);
    border-color: var(--bd-0) !important;
}

.notes .system-note .timeline-icon,
.notes .discussion-filter-note .timeline-icon,
.diff-file .file-title::before, .diff-file .file-title-flex-parent::before,
.gl-bg-gray-10 {
    background-color: var(--bg-1);
}

.file-holder,
.bordered-box,
.info-well .well-segment:not(:last-of-type),
.tree-holder table.tree-table tr:last-of-type,
.commit-description,
.commit-row-description,
.groups-list > li,
.top-area,
.group-list-tree .group-row:first-child,
.breadcrumbs-container,
.gl-border-t,
.gl-border-gray-100 {
    border-color: var(--bd-0);
}
.diff-file .diff-content {
    background-color: var(--bd-0);
}

.gl-text-body,
.gl-text-gray-500 {
    color: var(--co-0);
}

.diff-file.has-body .file-title {
    box-shadow: none;
}

.md, .md p, .md pre,
.text-muted,
h1, h2, h3, h4, h5, h6,
.h1, .h2, .h3, .h4, .h5, .h6,
.timeline .system-note .note-text,
.commit a, .generic-commit-status a,
ul.content-list li a,
.gl-text-gray-900\\! {
    color: var(--co-0) !important;
}
.mr-state-widget .label-branch,
.timeline-entry,
.breadcrumbs-list > li:last-child > a,
.nav-links li.active:not(.md-header-toolbar) a,
.nav-links li.active:not(.md-header-toolbar) button,
.nav-links li:not(.md-header-toolbar) a.active,
.nav-links li:not(.md-header-toolbar) a:active,
.nav-links li:not(.md-header-toolbar) a:hover,
.nav-links li:not(.md-header-toolbar) a:focus,
.file-holder .file-title a:not(.btn),
.context-header .sidebar-context-title {
    color: var(--co-2);
}
.note-headline-light,
.discussion-headline-light,
.detail-page-description .author-link {
    color: var(--bd-0);
}
code {
    color: var(--co-0);
    background-color: var(--bg-2);
}

.gfm-project_member,
.gl-bg-blue-50 {
    background-color: #072f56;
}

.gl-bg-orange-50 {
    background-color: #67522e;
}

.md h1, .md h2,
.content-block,
.issuable-discussion .main-notes-list::before,
.discussion-body .diff-file .file-title,
.code.white pre.code, .code.white .diff-line-num,
ul.content-list li {
    border-color: var(--bd-0);
}
.diff-file .notes_holder td.notes-content {
    padding-bottom: 0;
}

.project-stats .nav .stat-link .project-stat-value,
.project-buttons .nav .stat-link .project-stat-value,
.project-stats .nav .stat-link, .project-buttons .nav .stat-link {
    color: var(--co-0);
}

.breadcrumb.repo-breadcrumb a {
    color: var(--co-1);
}

.file-holder .file-content,
.tree-holder .tree-table {
    background-color: var(--bg-2);
}
.tree-holder table.tree-table tr td,
.tree-holder table.tree-table tr {
    border-color: var(--bd-0);
}
.tree-holder table.tree-table tr:hover:not(.tree-truncated-warning) td,
.md table:not(.code) tr th, table.table:not(.gl-table) tr th {
    background-color: var(--bg-3);
    color: var(--co-0);
    border-color: var(--bd-1);
}
.tree-holder .tree-item .tree-item-file-name i,
.tree-holder .tree-item .tree-item-file-name a,
.tree-holder .tree-commit .tree-commit-link,
.tree-holder .tree-time-ago {
    color: var(--co-0);
}

.notes .system-note .note-body .note-text.system-note-commit-list:not(.hide-shade)::after {
    background: linear-gradient(#0000 -100px, var(--bg-1) 100%);
}

.discussion .timeline-entry {
    border-radius: 0;
}

.row-content-block,
.filtered-search-box,
.filtered-search-box-input-container,
.file-title-flex-parent, .file-holder .file-title-flex-parent {
    background-color: var(--bg-2);
    border-color: var(--bd-0);
}
.diff-file .file-title:hover, .diff-file .file-title-flex-parent:hover {
    background-color: var(--bg-3);
}

.nav-sidebar,
.toggle-sidebar-button,
.right-sidebar:not(.right-sidebar-merge-requests),
.right-sidebar.right-sidebar-collapsed .gutter-toggle,
.right-sidebar.right-sidebar-collapsed .participants,
.discussion-body .discussion-reply-holder,
.disabled-comment,
.diff-file .notes_holder td.notes-content .notes,
.commit-header,
.info-well {
    background-color: var(--bg-2);
    border-color: var(--bd-0);
}
.toggle-sidebar-button:hover,
.group-list-tree .group-row-contents:hover {
    background-color: var(--bg-3);
}

.gl-tab-nav-item:hover {
    color: var(--co-1);
}

.gl-tab-nav-item-active,
.info-well,
.sidebar-top-level-items li > a.gl-link,
.gl-new-dropdown .gl-new-dropdown-section-header .dropdown-header {
    color: var(--co-0);
}
.gl-icon {
    fill: var(--co-0) !important;
}
.toggle-sidebar-button *,
.js-toggle-sidebar *,
.qa-toggle-sidebar *,
.rspec-toggle-sidebar * {
    color: var(--co-0) !important;
}
ul.fly-out-list {
    background-color: var(--bg-2) !important;
}
.nav-sidebar li.active:not(.fly-out-top-item) > a:not(.has-sub-items),
.nav-sidebar li > a:hover,
.diff-file-row.is-active {
    background-color: var(--bg-3);
}
body.ui-blue .nav-sidebar li.active > a {
    color: var(--co-2);
}

.gl-button.gl-button.btn-default-tertiary,
.gl-button.gl-button.btn-dashed-tertiary,
.gl-button.gl-button.btn-confirm-tertiary,
.gl-button.gl-button.btn-info-tertiary,
.gl-button.gl-button.btn-success-tertiary,
.gl-button.gl-button.btn-danger-tertiary,
.gl-button.gl-button.btn-block.btn-default-tertiary,
.gl-button.gl-button.btn-block.btn-dashed-tertiary,
.gl-button.gl-button.btn-block.btn-confirm-tertiary,
.gl-button.gl-button.btn-block.btn-info-tertiary,
.gl-button.gl-button.btn-block.btn-success-tertiary,
.gl-button.gl-button.btn-block.btn-danger-tertiary {
    mix-blend-mode: initial;
}

.btn {
    background-color: var(--bg-2) !important;
    color: var(--co-0) !important;
    border-color: var(--bd-0) !important;
    box-shadow: inset 0 0 0 1px var(--bd-0) !important;
}
.btn:hover, .btn:focus {
    background-color: var(--bg-3) !important;
    color: var(--co-2) !important;
    border-color: var(--bd-1) !important;
}

.clipboard-group .label-monospace,
.commit-sha-group .label-monospace,
.form-control,
.form-control:focus,
.gl-pagination .page-link {
    background-color: var(--bg-2);
    color: var(--co-0);
    border-color: var(--bd-0);
}
.gl-pagination .page-item.disabled .page-link {
    background-color: var(--bg-2);
    border-color: var(--bd-0);
}
.gl-pagination .page-link:not(.active):hover {
    background-color: var(--bg-3);
    color: var(--co-2);
}

.gl-dropdown .dropdown-menu,
.input-group .input-group-prepend, .input-group .input-group-append,
.gl-new-dropdown .dropdown-menu,
.dropdown-menu {
    background-color: var(--bg-2);
    color: var(--co-1) !important;
    border-color: var(--bd-0);
}
.gl-new-dropdown-item .dropdown-item,
.dropdown-menu li > a,
.dropdown-menu li button,
.dropdown-menu li .gl-button.btn-link,
.dropdown-menu li .menu-item {
    color: var(--co-0) !important;
}
.gl-new-dropdown-item .dropdown-item:not(.disable-hover):hover,
.gl-new-dropdown-item .dropdown-item:active,
.gl-new-dropdown-item .dropdown-item:focus,
.gl-new-dropdown-item .dropdown-item.is-focused {
    background-color: var(--bg-3);
    color: var(--co-2);
}

.git-clone-holder .form-control,
.dropdown-menu .divider {
    background-color: var(--bg-1);
    border-color: var(--bd-1);
}
.border-top {
    border-color: var(--bd-1) !important;
}

.code.white .line-numbers,
.code.white .diff-line-num,
.code.white .code-search-line,
.code.white .line_holder .diff-line-num {
    background-color: #515151;
}
.code.white, .code.white pre.code,
.code.white .line_holder .line_content {
    color: #d4d4d4;
}
.code.white .line_holder .diff-line-num.old,
.code.white .line_holder .diff-line-num.old-nomappinginraw {
    background-color: #78464e;
}
.code.white .line_holder .diff-line-num.old a,
.code.white .line_holder .diff-line-num.old-nomappinginraw a {
    color: #986d72;
}
.code.white .line_holder .diff-line-num.new,
.code.white .line_holder .diff-line-num.new-nomappinginraw {
    background-color: #295b38;
}
.code.white .line_holder .diff-line-num.new a,
.code.white .line_holder .diff-line-num.new-nomappinginraw a {
    color: #569a6a;
}
.code.white, .code.white pre.code, .code.white .line_holder .line_content,
.code.white .line_holder .line_content {
    background-color: #414141;
}
.code.white .line_holder .line_content.old,
.code.white .line_holder .line_content.old-nomappinginraw {
    background-color: #6c2d34;
}
.code.white .line_holder .line_content.new,
.code.white .line_holder .line_content.new-nomappinginraw {
    background-color: #266535;
}
.code.white .line_holder.diff-grid-row.expansion .diff-td {
    background-color: var(--bg-2);
    border-color: var(--bd-0) !important;
}
.code.white .diff-line-expand-button {
    background-color: var(--bg-3);
}
.diff-td.line-coverage.has-tooltip {
    background-color: #414141 !important;
}

.gl-badge.badge-muted {
    background-color: #666;
    color: #f0f0f0;
}
.gl-badge.badge-neutral {
    background-color: #525252;
    color: #dbdbdb;
}
.gl-badge.badge-info {
    background-color: #0b5cad;
    color: #cbe2f9;
}
.gl-badge.badge-success {
    background-color: #24663b;
    color: #c3e6cd;
}
.gl-badge.badge-warning {
    background-color: #8f4700;
    color: #f5d9a8;
}
.gl-badge.badge-danger {
    background-color: #ae1800;
    color: #fdd4cd;
}
.gl-badge.badge-tier {
    background-color: #5943b6;
    color: #e1d8f9;
}
`],


["mep - cppreference.com", {
  domains: [
    "cppreference.com",
  ],
}, `
body,
div#cpp-content-base {
    background-color: var(--bg-1);
    font-size: 20px;
}

div#cpp-head-first-base,
div#cpp-head-second-base,
div#cpp-footer-base {
    background: var(--bg-2);
    border-color: var(--bd-0);
}

input {
    background-color: var(--bg-2);
    color: var(--co-0);
    border: none;
}

div.vectorTabs:nth-child(1) { background: black; }
div.vectorTabs span { filter: invert(1); }
div.vectorTabs ul li { background: var(--bg-2); }
div.vectorTabs ul li.selected { background: var(--bg-3); }

.t-navbar-sep {
    filter: brightness(.6);
}
.t-navbar-head, .t-navbar-sep {
    border-color: var(--bd-1);
}
.t-navbar-menu > div {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}

.mainpagetable *, #userlogin, #userloginForm {
    background-color: var(--bg-2) !important;
    border-color: var(--bd-0) !important;
}

div#content {
    color: var(--co-0);
}
h1, h2, h3, h4, h5, h6 {
    color: var(--co-1);
    border-color: var(--bd-1);
}
.t-dsc > td, .t-dsc-hitem > td {
    border-color: var(--bd-1);
}

.t-inherited, .t-member, table.ambox {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}

.t-dcl > td,
.t-dcl-h > td,
.t-dcl-sep > td,
.t-dcl-rev > .t-dcl:first-child > td,
.t-dcl-rev > .t-dcl-rev-aux > td {
    border-color: var(--bd-1);
}
.t-dcl-rev > .t-dcl > td,
.t-dcl-rev > .t-dcl-h > td {
    border-color: var(--bd-0);
}

.t-rev-inl,
.t-sdsc-sep,
.t-rev > td:nth-child(1),
.t-rev > td:nth-child(2),
.dsctable > tbody > tr > td,
.dsctable > tbody > tr:last-child > td {
    border-color: var(--bd-0);
}

.t-inheritance-diagram img {
    filter: invert(.77);
}

pre {
    color: var(--co-0);
}
.t-c, pre, div.mw-geshi {
    background-color: var(--bg-0);
    border-color: var(--bd-0);
}
.cpp.source-cpp .sy1, .c.source-c .sy1,
.cpp.source-cpp .sy2, .c.source-c .sy2,
.cpp.source-cpp .sy3, .c.source-c .sy3 {
    color: #9d2226;
}
.cpp.source-cpp .nu0, .c.source-c .nu0,
.cpp.source-cpp .nu6, .c.source-c .nu6,
.cpp.source-cpp .nu8, .c.source-c .nu8,
.cpp.source-cpp .nu12, .c.source-c .nu12,
.cpp.source-cpp .nu16, .c.source-c .nu16,
.cpp.source-cpp .nu17, .c.source-c .nu17,
.cpp.source-cpp .nu18, .c.source-c .nu18,
.cpp.source-cpp .nu19, .c.source-c .nu19 {
    color: #e3c76a;
}
.cpp.source-cpp .kw1, .c.source-c .kw1,
.cpp.source-cpp .kw2, .c.source-c .kw2,
.cpp.source-cpp .kw3, .c.source-c .kw3,
.cpp.source-cpp .kw4, .c.source-c .kw4 {
    color: #226dee;
}

table.wikitable {
    background-color: var(--bg-1);
    color: var(--co-1);
}
table.wikitable > tr > th, table.wikitable > * > tr > th {
    background-color: var(--bg-2);
}
table.wikitable > tr > th, table.wikitable > tr > td, table.wikitable > * > tr > th, table.wikitable > * > tr > td {
    border-color: var(--bd-0);
}

a {
    color: #0c59d9 !important;
}
`],


["mep - python.org", {
  domains: [
    "python.org",
  ],
}, `
body/*, html*/ {
    background-color: var(--bg-0);
    margin: 0;
}

.version_switcher_placeholder, .language_switcher_placeholder {
    background: none;
}

div.related,
div.related ~ div.related,
div.footer {
    background-color: var(--bg-2);
    color: var(--co-0);
    border-color: var(--bd-1);
}
div.related a {
    color: var(--co-0);
}
div.related li.right {
    float: none;
}
div.related {
    margin-top: 0;
}
div.footer {
    margin-right: 0;
    padding-right: 10px;
}

.mobile-nav, .nav-content, .toggler__label {
    background-color: var(--bg-2);
    color: var(--co-0);
    border-color: var(--bd-1);
}
.language_switcher_placeholder select,
.version_switcher_placeholder select,
.search input {
    background-color: var(--bg-3) !important;
    color: var(--co-1) !important;
    border: solid 1px var(--bd-1);
    border-radius: 4px;
}

div.sphinxsidebar {
    background-color: var(--bg-3);
}
div.sphinxsidebar ul,
div.sphinxsidebar a {
    color: var(--co-0);
}
div.sphinxsidebar h3,
div.sphinxsidebar h3 a,
div.sphinxsidebar h4 {
    color: var(--co-1);
}

div.document {
    background-color: var(--bg-0);
    margin: 1.5rem;
}
@media (min-width: 1023px) {
    div.document {
        padding-left: 1em;
        padding-right: 1em;
        padding-top: 0.5em;
    }
    div.bodywrapper {
        margin-left: 25.43%;
    }
}
@media (max-width: 1023px) {
    div.body {
        min-width: calc(100% - 3rem);
    }
}
div.body {
    background-color: var(--bg-1);
    color: var(--co-0);
    border: solid 1px var(--bd-0);
    padding: 1.5rem;
}

div.body h1, div.body h2, div.body h3, div.body h4, div.body h5, div.body h6 {
    background-color: var(--bg-1);
    color: var(--co-1);
}

div.seealso {
    filter: brightness(.72);
    color: var(--bg-2);
}
dt:target, span.highlighted {
    background-color: #7f742e;
}

table.docutils td, table.docutils th {
    border-color: var(--bd-1) !important;
    border-radius: 0;
}
table.docutils th {
    background-color: var(--bg-3);
}
table.docutils td {
    background-color: var(--bg-2);
}

div.note {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}

code, .note code, div.body pre {
    background-color: var(--bg-0);
    color: var(--co-0);
    border-color: var(--bd-0);
}
.copybutton {
    filter: brightness(.42);
}
.highlight .gp {
    color: #43438e;
}
.highlight .nc {
    color: #2a2ae9;
}
`],


["mep - lua.org", {
  domains: [
    "lua.org",
  ],
}, `
html {
    background-color: var(--bg-0);
}

body {
    background-color: var(--bg-1);
    color: var(--co-0);
    border-color: var(--bd-0);
    font-family: sans-serif;
}

h1, h2, h3, h4 {
    color: var(--co-1);
}

img {
    background-color: unset;
}
td img, h1 a img {
    filter: invert(.88);
}
td.news ul {
    border-color: var(--bd-1);
}

code, pre {
    background-color: var(--bg-2);
    border: solid 1px var(--bd-1);
    border-radius: 4px;
}

a:link {
	color: #5555e5;
}
a:visited {
	color: #9555e5;
}
a:link:hover, a:visited:hover {
	background-color: var(--bg-2);
	color: #5555e5;
}
a:link:active, a:visited:active {
	color: #FF0000;
}
:target {
	background-color: var(--bg-3);
}

table.nav img {
    filter: invert(.8);
}

p.warning {
    color: var(--co-0);
}
`],


["mep - news.ycombinator", {
  domains: [
    "news.ycombinator.com",
  ],
}, `
body {
    background-color: var(--bg-0);
}
.comment {
    font-size: 1rem;
}
tr:not(:first-of-type) {
    background-color: var(--bg-1);
}
.c00, .c00 a:link, a:link, a:visited {
    color: var(--co-0);
}
#pagespace::after {
    content: ' ';
}

/*body {
    padding: 0px;
    margin: 0px;
    min-height: 98vh;
}*/

@media only screen and (min-width: 780px) {
    body {
        padding: 1vh 20vw 1vh 5vw;
    }
}

@media only screen and (min-width: 900px) {
    body {
        padding: 1vh 1vw 1vh 1vw;
    }
}

@media only screen and (min-width: 1200px) {
    body {
        padding: 1vh 25vw 1vh 20vw;
    }
}
`],


["mep - Read the Docs", {
  domains: [
    "readthedocs.io",
    "docs.mesa3d.org",
    "docs.ros.org",
    "docs.blender.org",
    "firefox-source-docs.mozilla.org",
    "docs.ansible.com",
    "flake8.pycqa.org",
    "supervisord.org",
    "docs.pyglet.org",
    "docs.pyinvoke.org",
    "docs.celeryq.dev",
    "docs.aiohttp.org",
  ],
  urlPrefixes: [
    "https://kernel.org/doc/html",
  ],
}, `
body {
    color: var(--co-0);
    background-color: var(--bg-0);
}
div.body {
    color: var(--co-1);
    background-color: var(--bg-1);
}


h1, h2, h3, h4, h5, h6,
div.body h1, div.body h2, div.body h3, div.body h4, div.body h5, div.body h6 {
    color: var(--co-1);
    background-color: inherit;
}
.wy-body-for-nav {
    background-color: var(--bg-0);
}
.wy-nav-content,
.wy-nav-content-wrap {
    background-color: var(--bg-1);
}
@media only screen and (min-width: 1700px) {
    .wy-nav-content {
        margin-left: 200px;
    }
}
hr {
    border-color: var(--bd-0);
}

div.sphinxsidebar * {
    color: var(--co-0) !important;
}

table.ansible-option-table tbody .row-odd td,
table.ansible-option-table td:first-child > div.ansible-option-cell,
table.ansible-option-table td > div.ansible-option-cell,
.rst-content table.docutils,
.wy-table-bordered-all,
table.docutils th,
table.docutils td,
table {
    border-color: var(--bd-1) !important;
}
table.docutils tr th,
table.docutils tr td,
table.ansible-option-table tbody .row-odd td,
table.ansible-option-table td:first-child > div.ansible-option-cell {
    background-color: var(--bg-2) !important;
}
table.docutils tr:nth-child(2n-1) td {
    background-color: var(--bg-3) !important;
}

.highlight,
.rst-content div[class^='highlight'],
.rst-content .guilabel,
.rst-content .menuselection,
.rst-content code, .rst-content tt, code {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}
.highlight .go {
    color: var(--co-1);
}
.highlight .l {
    color: #2a95e7;
}
div[class^="highlight"] pre, .n,
.rst-content code, .rst-content tt {
    color: var(--co-2);
}
.rst-content code.xref, .rst-content tt.xref, .rst-content code.literal,
a .rst-content code, a .rst-content tt {
    color: var(--co-1);
}
.rst-content .toc-backref {
    color: inherit;
}

.rst-content .admonition,
.rst-content .admonition-todo,
.rst-content .attention,
.rst-content .caution,
.rst-content .danger,
.rst-content .error,
.rst-content .hint,
.rst-content .important,
.rst-content .note,
.rst-content .seealso,
.rst-content .tip,
.rst-content .warning,
.rst-content .refbox,
div.admonition,
div.admonition-todo,
div.attention,
div.caution,
div.danger,
div.error,
div.hint,
div.important,
div.note,
div.seealso,
div.tip,
div.warning,
div.refbox,
.rst-content .wy-alert-info.admonition,
.rst-content .wy-alert-info.admonition-todo,
.rst-content .wy-alert-info.attention,
.rst-content .wy-alert-info.caution,
.rst-content .wy-alert-info.danger,
.rst-content .wy-alert-info.error,
.rst-content .wy-alert-info.hint,
.rst-content .wy-alert-info.important,
.rst-content .wy-alert-info.tip,
.rst-content .wy-alert-info.warning,
.wy-alert.wy-alert-info,
.sig.sig-object.py {
   background-color: var(--bg-3) !important;
}

.wy-menu-vertical li.current a,
.wy-menu-vertical li.toctree-l1.current > a,
.wy-menu-vertical li.toctree-l3.current > a,
.wy-menu-vertical li.toctree-l3.current li.toctree-l4 > a,
.btn-neutral:visited, .btn-neutral {
    background-color: var(--bg-1);
    color: var(--co-2) !important;
    border-color: var(--bd-1);
}
.btn-neutral {
    background-color: var(--bg-2) !important;
}
.wy-menu-vertical li.current a:hover {
    background-color: var(--bg-3);
}
.wy-menu-vertical li.toctree-l2.current > a,
.wy-menu-vertical li.toctree-l2.current li.toctree-l3 > a {
    background-color: var(--bg-2);
}
.wy-menu-vertical li.current > a:hover,
.wy-menu-vertical li.on a:hover,
.btn-neutral:hover {
    background-color: var(--bg-3) !important;
    color: var(--co-2);
}

.rst-content dl:not(.docutils) dl dt,
.rst-content dl:not(.docutils) dt,
.rst-content dl:not(.docutils) dt span {
    background-color: var(--bg-2) !important;
    color: var(--co-0) !important;
    border-color: var(--bd-1) !important;
}

div.note,
div.seealso,
div.highlight > pre {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}

a {
    color: #3167d8;
}
a:visited {
    color: #7431d8;
}


/*! Monokai theme; http://blog.favrik.com/2011/02/22/preview-all-pygments-styles-for-your-code-highlighting-needs/#stylesheetNavigator */
.highlight, .highlight pre, .highlight pre span, .highlight table, code { background: #272822 !important; color: #e8e8e2 !important; }
.highlight .hll { background-color: #49483e !important; }
.highlight .c { color: #75715e !important; } /* Comment */
.highlight .err { color: #960050 !important; background-color: #1e0010 !important; } /* Error */
.highlight .k { color: #66d9ef !important; } /* Keyword */
.highlight .l { color: #ae81ff !important; } /* Literal */
.highlight .n, .highlight .h { color: #f8f8f2 !important; } /* Name */
.highlight .o { color: #f92672 !important; } /* Operator */
.highlight .p { color: #f8f8f2 !important; } /* Punctuation */
.highlight .cm { color: #75715e !important; } /* Comment.Multiline */
.highlight .cp { color: #75715e !important; } /* Comment.Preproc */
.highlight .c1 { color: #75715e !important; } /* Comment.Single */
.highlight .cs { color: #75715e !important; } /* Comment.Special */
/*.highlight .ge { } /* Generic.Emph */
/*.highlight .gs { } /* Generic.Strong */
.highlight .kc { color: #66d9ef !important; } /* Keyword.Constant */
.highlight .kd { color: #66d9ef !important; } /* Keyword.Declaration */
.highlight .kn { color: #f92672 !important; } /* Keyword.Namespace */
.highlight .kp { color: #66d9ef !important; } /* Keyword.Pseudo */
.highlight .kr { color: #66d9ef !important; } /* Keyword.Reserved */
.highlight .kt { color: #66d9ef !important; } /* Keyword.Type */
.highlight .ld { color: #e6db74 !important; } /* Literal.Date */
.highlight .m { color: #ae81ff !important; } /* Literal.Number */
.highlight .s { color: #e6db74 !important; } /* Literal.String */
.highlight .na { color: #a6e22e !important; } /* Name.Attribute */
.highlight .nb { color: #f8f8f2 !important; } /* Name.Builtin */
.highlight .nc { color: #a6e22e !important; } /* Name.Class */
.highlight .no { color: #66d9ef !important; } /* Name.Constant */
.highlight .nd { color: #a6e22e !important; } /* Name.Decorator */
.highlight .ni { color: #f8f8f2 !important; } /* Name.Entity */
.highlight .ne { color: #a6e22e !important; } /* Name.Exception */
.highlight .nf { color: #a6e22e !important; } /* Name.Function */
.highlight .nl { color: #f8f8f2 !important; } /* Name.Label */
.highlight .nn { color: #f8f8f2 !important; } /* Name.Namespace */
.highlight .nx { color: #a6e22e !important; } /* Name.Other */
.highlight .py { color: #f8f8f2 !important; } /* Name.Property */
.highlight .nt { color: #f92672 !important; } /* Name.Tag */
.highlight .nv { color: #f8f8f2 !important; } /* Name.Variable */
.highlight .ow { color: #f92672 !important; } /* Operator.Word */
.highlight .w { color: #f8f8f2 !important; } /* Text.Whitespace */
.highlight .mf { color: #ae81ff !important; } /* Literal.Number.Float */
.highlight .mh { color: #ae81ff !important; } /* Literal.Number.Hex */
.highlight .mi { color: #ae81ff !important; } /* Literal.Number.Integer */
.highlight .mo { color: #ae81ff !important; } /* Literal.Number.Oct */
.highlight .sb { color: #e6db74 !important; } /* Literal.String.Backtick */
.highlight .sc { color: #e6db74 !important; } /* Literal.String.Char */
.highlight .sd { color: #e6db74 !important; } /* Literal.String.Doc */
.highlight .s2 { color: #e6db74 !important; } /* Literal.String.Double */
.highlight .se { color: #ae81ff !important; } /* Literal.String.Escape */
.highlight .sh { color: #e6db74 !important; } /* Literal.String.Heredoc */
.highlight .si { color: #e6db74 !important; } /* Literal.String.Interpol */
.highlight .sx { color: #e6db74 !important; } /* Literal.String.Other */
.highlight .sr { color: #e6db74 !important; } /* Literal.String.Regex */
.highlight .s1 { color: #e6db74 !important; } /* Literal.String.Single */
.highlight .ss { color: #e6db74 !important; } /* Literal.String.Symbol */
.highlight .bp { color: #f8f8f2 !important; } /* Name.Builtin.Pseudo */
.highlight .vc { color: #f8f8f2 !important; } /* Name.Variable.Class */
.highlight .vg { color: #f8f8f2 !important; } /* Name.Variable.Global */
.highlight .vi { color: #f8f8f2 !important; } /* Name.Variable.Instance */
.highlight .il { color: #ae81ff !important; } /* Literal.Number.Integer.Long */
`],


["mep - Ruby", {
  domains: [
    "ruby-lang.org",
  ],
}, `
body, main {
    background-color: var(--bg-0);
    color: var(--co-0);
}
#header {
    background-color: var(--bg-1);
    border-color: var(--bd-1);
}
#sidebar {
    background-color: var(--bg-2);
    text-shadow: 0 1px 0 var(--bd-0);
    border-color: var(--bd-0);
}
#sidebar h3 {
    color: var(--co-1);
    border-color: var(--bd-1);
}
#footer {
    background-color: var(--bg-1);
    border-color: var(--bd-1);
    text-shadow: none;
}
#footer div.site-links {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}

#home-page-layout #code pre {
    margin: revert;
    filter: invert(1);
}
#home-page-layout #intro-container {
    filter: invert(1);
}
#home-page-layout #intro p {
    color: #0ff;
}
#header_content > a {
    filter: invert(.88);
}

code, pre {
    color: var(--co-1);
    border-color: var(--bd-1);
    text-shadow: none;
}
pre {
    box-shadow: 0 0 4px var(--bd-1) inset;
}

/*! Monokai theme; http://blog.favrik.com/2011/02/22/preview-all-pygments-styles-for-your-code-highlighting-needs/#stylesheetNavigator */
.highlight, .highlight pre, .highlight table, code { background: #272822 !important; color: #e8e8e2 !important; }
.highlight .hll { background-color: #49483e !important; }
.highlight .c { color: #75715e !important; } /* Comment */
.highlight .err { color: #960050 !important; background-color: #1e0010 !important; } /* Error */
.highlight .k { color: #66d9ef !important; } /* Keyword */
.highlight .l { color: #ae81ff !important; } /* Literal */
.highlight .n, .highlight .h { color: #f8f8f2 !important; } /* Name */
.highlight .o { color: #f92672 !important; } /* Operator */
.highlight .p { color: #f8f8f2 !important; } /* Punctuation */
.highlight .cm { color: #75715e !important; } /* Comment.Multiline */
.highlight .cp { color: #75715e !important; } /* Comment.Preproc */
.highlight .c1 { color: #75715e !important; } /* Comment.Single */
.highlight .cs { color: #75715e !important; } /* Comment.Special */
/*.highlight .ge { } /* Generic.Emph */
/*.highlight .gs { } /* Generic.Strong */
.highlight .kc { color: #66d9ef !important; } /* Keyword.Constant */
.highlight .kd { color: #66d9ef !important; } /* Keyword.Declaration */
.highlight .kn { color: #f92672 !important; } /* Keyword.Namespace */
.highlight .kp { color: #66d9ef !important; } /* Keyword.Pseudo */
.highlight .kr { color: #66d9ef !important; } /* Keyword.Reserved */
.highlight .kt { color: #66d9ef !important; } /* Keyword.Type */
.highlight .ld { color: #e6db74 !important; } /* Literal.Date */
.highlight .m { color: #ae81ff !important; } /* Literal.Number */
.highlight .s { color: #e6db74 !important; } /* Literal.String */
.highlight .na { color: #a6e22e !important; } /* Name.Attribute */
.highlight .nb { color: #f8f8f2 !important; } /* Name.Builtin */
.highlight .nc { color: #a6e22e !important; } /* Name.Class */
.highlight .no { color: #66d9ef !important; } /* Name.Constant */
.highlight .nd { color: #a6e22e !important; } /* Name.Decorator */
.highlight .ni { color: #f8f8f2 !important; } /* Name.Entity */
.highlight .ne { color: #a6e22e !important; } /* Name.Exception */
.highlight .nf { color: #a6e22e !important; } /* Name.Function */
.highlight .nl { color: #f8f8f2 !important; } /* Name.Label */
.highlight .nn { color: #f8f8f2 !important; } /* Name.Namespace */
.highlight .nx { color: #a6e22e !important; } /* Name.Other */
.highlight .py { color: #f8f8f2 !important; } /* Name.Property */
.highlight .nt { color: #f92672 !important; } /* Name.Tag */
.highlight .nv { color: #f8f8f2 !important; } /* Name.Variable */
.highlight .ow { color: #f92672 !important; } /* Operator.Word */
.highlight .w { color: #f8f8f2 !important; } /* Text.Whitespace */
.highlight .mf { color: #ae81ff !important; } /* Literal.Number.Float */
.highlight .mh { color: #ae81ff !important; } /* Literal.Number.Hex */
.highlight .mi { color: #ae81ff !important; } /* Literal.Number.Integer */
.highlight .mo { color: #ae81ff !important; } /* Literal.Number.Oct */
.highlight .sb { color: #e6db74 !important; } /* Literal.String.Backtick */
.highlight .sc { color: #e6db74 !important; } /* Literal.String.Char */
.highlight .sd { color: #e6db74 !important; } /* Literal.String.Doc */
.highlight .s2 { color: #e6db74 !important; } /* Literal.String.Double */
.highlight .se { color: #ae81ff !important; } /* Literal.String.Escape */
.highlight .sh { color: #e6db74 !important; } /* Literal.String.Heredoc */
.highlight .si { color: #e6db74 !important; } /* Literal.String.Interpol */
.highlight .sx { color: #e6db74 !important; } /* Literal.String.Other */
.highlight .sr { color: #e6db74 !important; } /* Literal.String.Regex */
.highlight .s1 { color: #e6db74 !important; } /* Literal.String.Single */
.highlight .ss { color: #e6db74 !important; } /* Literal.String.Symbol */
.highlight .bp { color: #f8f8f2 !important; } /* Name.Builtin.Pseudo */
.highlight .vc { color: #f8f8f2 !important; } /* Name.Variable.Class */
.highlight .vg { color: #f8f8f2 !important; } /* Name.Variable.Global */
.highlight .vi { color: #f8f8f2 !important; } /* Name.Variable.Instance */
.highlight .il { color: #ae81ff !important; } /* Literal.Number.Integer.Long */
`],


["mep - Hackage Haskell", {
  domains: [
    "hackage.haskell.org",
  ],
}, `
html {
    background-color: var(--bg-0);
}
body {
    background-color: var(--bg-0);
    color: var(--co-0);
}

#contents-list {
    background-color: var(--bg-3);
}
table.info, #footer {
    background-color: var(--bg-3);
    color: var(--co-2);
    border-color: var(--bd-1);
}

.top {
    background-color: var(--bg-1);
}
.src, .subs .subs p.src {
    background-color: var(--bg-2);
}
.top p.src {
    border-color: var(--bd-0);
}
.subs, .top > .doc, .subs > .doc {
    border-color: var(--bd-1);
}
pre {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}
#synopsis ul, #synopsis ul li.src {
    background-color: var(--bg-3);
}

pre.screen {
    margin-right: 1em;
}
.top > div:last-of-type {
    padding-bottom: 1em;
}

.prompt {
    color: #c35555;
}
.userinput {
    color: #2f83b4;
}
a[href]:link, a[href]:visited {
    color: #dc75cc;
}

table.fancy, table.fancy tr {
    border-color: var(--bd-0);
}
#browseTable th {
    background-color: var(--bg-2);
    border-color: var(--bd-0);
}
table.fancy tbody {
    background-color: var(--bg-1);
}
.paginator .current, .paginator .current:hover {
    background: var(--bg-3);
    color: var(--co-2) !important;
    border-color: var(--bd-1);
}
`],


["mep - Hoogle Haskell", {
  domains: [
    "hoogle.haskell.org",
  ],
}, `
html {
    background-color: var(--bg-0);
}

#logo img {
    filter: invert(.935);
}
.result {
    margin-left: 20vw;
    margin-right: 20vw;
}

.ans {
    background-color: var(--bg-1);
    border-color: var(--bd-1);
}
.ans a {
    color: var(--co-1);
}
.doc, .doc a {
    color: var(--co-0);
}
a:hover {
    background-color: #662;
}

#footer {
    background-color: var(--bg-2);
    color: var(--co-2);
    border-color: var(--bd-1);
}
`],


["mep - cplusplus.com", {
  domains: [
    "cplusplus.com",
  ],
}, `
body {
    background-color: var(--bg-0);
    color: var(--co-0);
}

#I_nav, #I_main {
    background-color: var(--bg-1);
}
#I_bar, #I_nav .sect {
    background-color: var(--bg-3);
    border-color: var(--bd-1);
}

h1, h2, h3, h4,
.C_doc #I_description {
    color: var(--co-1);
}

.C_doc .hierarchy LI B {
    border-color: var(--bd-1);
}
.C_doc .hierarchy LI B::before {
    filter: invert(.48);
}

.C_doc .links, .C_doc .links dt,
table.boxed th {
    background-color: var(--bg-3);
    color: var(--co-2);
    border-color: var(--bd-0);
}
.C_doc .links dd, .auto .output,
table.boxed td {
    background-color: var(--bg-2) !important;
    color: var(--co-1);
    border-color: var(--bd-0);
}

.C_doc .C_prototype,
.C_doc #parameters DT, .C_doc #requirements DT,
.C_deco tr.odd td, .C_deco tr.even td, .C_forThread .bot, .C_deco tr td {
    background-color: var(--bg-2);
}
.C_forPost .boxtop, .C_forPost .dwhat .quote td.qd, .auto .source {
    background-color: var(--bg-3);
    border-color: var(--bd-1);
}
.C_forPost .box {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}

.C_doc a, .C_doc a:visited, a {
    color: #8080ee;
}

.gsc-input-box {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}
input.gsc-input, table[role='presentation'][style] {
    background-color: var(--bg-2) !important;
    color: var(--co-2);
}
.gsc-control-cse {
    background-color: var(--bg-2);
    border-color: var(--bd-0);
}
.gsc-above-wrapper-area {
    border: none;
}
.gsc-webResult.gsc-result, .gsc-results .gsc-imageResult {
    background-color: var(--bg-3);
    border-color: var(--bd-1);
}
.gsc-webResult.gsc-result:hover {
    background-color: var(--bg-2);
}
.gs-webResult:not(.gs-no-results-result):not(.gs-error-result) .gs-snippet,
.gs-fileFormatType {
    color: var(--co-1);
}
.gs-webResult.gs-result a.gs-title,
.gs-webResult.gs-result a.gs-title b,
.gs-imageResult a.gs-title,
.gs-imageResult a.gs-title b {
    color: var(--co-2) !important;
}
.gsc-results .gsc-cursor-box .gsc-cursor-page {
    background-color: inherit;
}
`],


["mep - crates.io", {
  domains: [
    "crates.io",
  ],
}, `
:root, [data-theme="classic"] {
    --main-bg: var(--bg-0);
    --main-bg-dark: var(--bg-2);
    --main-color: var(--co-0);
    --gray-border: var(--bd-0);
}

nav[aria-label~=subpages]+div>div:first-child {
    background-color: var(--bg-1);
}
nav[aria-label~=subpages]~ul>li>div {
    background-color: var(--bg-1);
    --hover-bg-color: var(--bg-2) !important;
}

section[aria-label~=metadata]>div>p+button:hover {
    background-color: var(--bg-2);
}

div[class*=dropdown]>ul {
    background-color: var(--bg-2);
}

main>div>div>section>ol>li>a,
main>div>div>section>ul>li>a,
main>div>div>ol>li>div {
    background-color: var(--bg-1) !important;
}
main>div>div>ol>li>div svg>circle {
    fill: var(--bg-1);
}

h1, h2, h3, h4 {
    color: var(--co-2) !important;
}

code {
    background-color: var(--bg-2) !important;
}
table th, table td {
    border-color: var(--bd-1) !important;
}

.hljs {
    color: var(--co-2);
}
.hljs-code, .hljs-comment, .hljs-formula {
    color: #b6b7b7;
}
.hljs-meta .hljs-string, .hljs-regexp, .hljs-string {
    color: #13f729;
}
.hljs-attr, .hljs-attribute, .hljs-literal, .hljs-meta, .hljs-number, .hljs-operator, .hljs-selector-attr, .hljs-selector-class, .hljs-selector-id, .hljs-variable {
    color: #2d81e1;
}

input {
    background-color: var(--bg-2);
    color: var(--co-2) !important;
}

canvas {
    filter: invert(1);
}
`],


["mep - Quora", {
  domains: [
    "quora.com",
  ],
}, `
html, body {
    background-color: var(--bg-0) !important;
    color: var(--co-0);
}

.qu-bg--raised {
    background-color: var(--bg-1);
}
.qu-borderColor--raised,
.qu-borderTop,
.qu-borderBottom {
    border-color: var(--bd-0) !important;
}

.qu-color--gray_dark_dim {
    color: var(--co-2);
}
.qu-color--gray_dark {
    color: var(--co-3);
}

.qu-borderColor--gray {
    border-color: var(--bd-1) !important;
}
div[data-placement*='bottom']::before,
div[data-placement*='bottom']::after {
    border-color: transparent transparent var(--bd-1) !important;
}

div[style*='linear-gradient'] {
    background: linear-gradient(transparent 0%, var(--bg-1) 100%) !important;
}
div[style*=filter] {
    filter: initial !important;
}
div[class*=blocking] {
    display: none !important;
}
.qu-overflow--hidden, body {
    overflow: visible !important;
}

.qu-bg--poe_gray_light {
    background-color: var(--bg-3);
}
.qu-color--poe_gray_dark {
    color: var(--co-1);
}
`],


["mep - Google Translate", {
  domains: [
    "translate.google.com",
  ],
}, `
c-wiz>div {
    background-color: var(--bg-1) !important;
    color: var(--co-0) !important;
    border-color: var(--bd-0) !important;
}
body>c-wiz {
    background-color: var(--bg-0) !important;
}
header {
    background-color: var(--bg-2) !important;
}

nav::after, div::after {
    background: linear-gradient(to right, transparent, var(--bg-1)) !important;
}

html body c-wiz div div c-wiz div c-wiz div div div c-wiz div div div div span span span {
    color: var(--co-1);
}
html body c-wiz div div c-wiz div c-wiz div div div c-wiz span span div textarea {
    color: var(--co-1) !important;
}
html body c-wiz div div c-wiz div c-wiz div div div c-wiz span span div div span {
    display: none;
}

c-wiz>div>div>div>div[id] {
    background-color: var(--bg-2) !important;
    border-color: var(--bd-1) !important;
}
li>span, q {
    color: var(--co-0);
}
span[lang] {
    color: var(--co-2);
}

div[aria-live="polite"]>div>div>span>span:hover {
    background-color: var(--bg-3) !important;
}
div[aria-live="polite"]>div>div>span>span>div,
div[aria-live="polite"]>div>div>span>span>div>div {
    background-color: var(--bg-2) !important;
    border-color: var(--bd-1);
}
div[aria-live="polite"]>div>div>span>span>div>div:hover {
    background-color: var(--bg-3) !important;
}

button {
    border-color: var(--bd-1) !important;
}

ul[role='listbox'] {
    background-color: var(--bg-1);
}
ul[role='listbox']>li[aria-selected='true'] {
    background-color: var(--bg-2);
}
ul[role='listbox']>li>div:first-of-type {
    color: var(--co-1);
}

nav>a>div:first-of-type {
    background-color: var(--bg-2);
}
nav>a>div:last-of-type {
    color: var(--co-0);
}

.ita-hwt-ime,
.ita-hwt-candidates,
.ita-hwt-candidate,
.ita-hwt-buttons {
    background-color: var(--bg-2);
    color: var(--co-1);
    border-color: var(--bd-1);
}
.ita-hwt-candidate-hover,
.ita-hwt-jfk-standard,
.ita-hwt-jfk-standard.ita-hwt-jfk-hover {
    background: var(--bg-1);
}
.ita-kd-img,
.ita-hwt-grip,
.ita-hwt-close {
    filter: invert(.82);
}
canvas.ita-hwt-canvas {
    cursor: crosshair;
}

c-wiz[role='region']>div[jsname]>div>div>div[jsname]>div,
c-wiz[role='region']>div[jsname]>div {
    background-color: var(--bg-2) !important;
    border-color: var(--bd-1) !important;
}
c-wiz[role='region']>div[jsname]>div>div>div[jsname]>div>div,
c-wiz[role='region']>div[jsname]>div>div {
    border-color: var(--bd-1) !important;
}
c-wiz[role='region'] h3>span {
    color: var(--co-2);
}

c-wiz>div>div>c-wiz>div>c-wiz>div>div>c-wiz>div>c-wiz/*[jsrenderer="Sx55ld"]*/ {
    border-color: var(--bd-1) !important;
}
c-wiz>div>div>c-wiz>div>c-wiz>div>div>c-wiz>div>c-wiz>div>div[data-auto-open-search]>div,
c-wiz>div>div>c-wiz>div>c-wiz>div>div>c-wiz>div>c-wiz>div>div[data-auto-open-search]>div>input {
    background-color: var(--bg-2);
}
c-wiz>div>div>c-wiz>div>c-wiz>div>div>c-wiz>div>c-wiz>div>div[data-auto-open-search]>div[role="listbox"] {
    background-color: var(--bg-2);
}
c-wiz>div>div>c-wiz>div>c-wiz>div>div>c-wiz>div>c-wiz>div>div[data-auto-open-search]>div[role="listbox"]>div>div>div[aria-selected] {
    color: var(--co-0);
}
c-wiz>div>div>c-wiz>div>c-wiz>div>div>c-wiz>div>c-wiz>div>div[data-auto-open-search]>div[role="listbox"]>div>div>div[aria-selected]:hover {
    background-color: var(--bg-3);
}
c-wiz>div>div>c-wiz>div>c-wiz>div>div>c-wiz>div>c-wiz>div>div[data-auto-open-search]>div[role="listbox"]>div>div>div[aria-selected="true"] {
    background-color: var(--bg-3);
}
`],


["mep - Doxygen", {
  regexps: [
    "https://.*/doxygen/.*",
  ],
  urlPrefixes: [
    "https://gcc.gnu.org/onlinedocs/libstdc++/latest-doxygen",
    "https://microsoft.github.io/cpprestsdk",
  ],
}, `
body {
    background-color: var(--bg-0);
    color: var(--co-0);
}

.sm-dox {
    background: var(--bg-2);
}
.sm-dox a,
.sm-dox a:focus,
.sm-dox a:active,
.sm-dox a:hover,
.sm-dox a.highlighted {
    background-image: none;
    border-right: solid 1px var(--bd-1);
    text-shadow: none;
    color: var(--co-1);
}
.sm-dox ul,
.sm-dox ul a,
.sm-dox ul a:focus,
.sm-dox ul a:hover,
.sm-dox ul a:active {
    background-color: var(--bg-2);
    color: var(--co-0);
    border-color: var(--bd-1);
}
.sm-dox span.scroll-up,
.sm-dox span.scroll-down {
    background-color: var(--bg-1);
}

.navpath ul {
    background: var(--bg-2);
    border-color: var(--bd-0);
}
.navpath li.navelem a {
    text-shadow: none;
    color: var(--co-0);
}

div.header {
    background: var(--bg-1);
    border-color: var(--bd-1);
}

div.center>img {
    filter: invert(.7);
}

/* list top of page */
.mdescLeft,
.mdescRight,
.memItemLeft,
.memItemRight,
.memTemplItemLeft,
.memTemplItemRight,
.memTemplParams {
    background-color: var(--bg-1);
}
.memSeparator {
    border-color: var(--bd-0);
}
/*-*/

/* individual definitions */
.memtitle {
    background: var(--bg-1);
    border-color: var(--bd-1);
}
.memproto, dl.reflist dt {
    background-color: var(--bg-1);
    border-color: var(--bd-1);
}
.memdoc, dl.reflist dd {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}
.memproto, dl.reflist dt {
    text-shadow: none;
    color: #11a72d;
}
.paramname {
    color: #e9603e;
}
/*-*/
`],


["mep - time.is", {
  domains: [
    "time.is",
  ],
}, `
body {
    color: var(--co-1);
}
html,
#mainwrapper {
    background-color: var(--bg-2);
}
.caln td div {
    border-color: var(--bd-1);
}
`],


["mep - Bugzilla", {
  regexps: [
    ".*/bugzilla/.*",
    ".*show_bug\\.cgi\\?.*",
  ],
}, `
body {
    background-color: var(--bg-0);
}
#bugzilla-body {
    background-color: var(--bg-1);
    color: var(--co-0);
}
.bz_short_desc_container,
.bz_comment {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}

#attachment_table th, .bz_attach_footer, .bz_time_tracking_table th, .dependency_tree_controls {
    background-color: var(--bg-2);
    color: var(--co-2);
}

#comments>table {
    margin: auto;
}

.bz_comment_text span.quote {
    color: #be99e9;
}
`],


["mep - Rust Playground", {
  domains: [
    "play.rust-lang.org",
  ],
}, `
:root {
    --border-color: var(--bd-1);
    --header-main-border: var(--bd-0);
}

body {
    background-color: var(--bg-0);
}

button[title] *, a[title] * {
    background-color: var(--bg-2);
    color: var(--co-1);
}

html>body>main>div#playground>div:nth-of-type(1)>div:nth-of-type(2)>div:nth-of-type(3) * {
    background-color: var(--bg-1);
}
`],


["mep - Unity Documentation", {
  domains: [
    "unity3d.com",
    "unity.com",
  ],
}, `
body {
    background-color: var(--bg-1);
    color: var(--co-0);
}

.sidebar-wrap, div.toolbar {
    background-color: var(--bg-0);
}
div.sidebar-menu ul li a {
    color: var(--co-0);
}
div.sidebar-wrap {
    border-color: var(--bd-0);
}

h1, h2, h3, h4, h5, h6 {
    color: var(--co-2);
}

.content .section table tbody td,
.content .section table thead th,
div.sidebar-menu h2 {
    border-color: var(--bd-1);
}

table.list tr:nth-child(2n+1),
.content .section table thead th,
.feedbackbox, .nextprev {
    background-color: var(--bg-2);
}
div.icon span {
    background-color: var(--bg-3);
}

textarea, input,
.form-actions {
    background-color: inherit !important;
}

.sidetoc, body .toc, .sidefilter, .navbar-default {
    background-color: inherit;
    border-color: var(--bd-1);
}
footer {
    display: none !important;
}

.answer-list .widget-content .answer-container,
.answer-list .widget-content .reply-container {
    background-color: var(--bg-2);
}
.accepted-answer .answer {
    background-color: #314628;
    color: inherit;
}

code, pre {
    background-color: var(--bg-2);
    color: var(--co-0);
}
li.L2, li.L4, li.L6, li.L8, li.L0 {
    background-color: #313131;
}
li.L1, li.L3, li.L5, li.L7, li.L9 {
    background-color: #363636;
}
.pln { color: #d0cccc }
.str { color: #73ca73 }
.kwd { color: #0d82ff }
.com { color: #8e3737 }
.typ { color: #f4f285 }
.lit { color: #00c8c8 }
.pun,
.opn,
.clo { color: #ff2667 }
.tag { color: #3434ca }
.atn { color: #ce38ce }
.atv { color: #36c636 }
.dec,
.var { color: #bf34bf }
.fun { color: #ee2e2e }
`],


["mep - docs.oracle.com", {
  domains: [
    "docs.oracle.com",
  ],
}, `
body {
    background-color: var(--bg-1);
    color: var(--co-0);
    font-size: 100%;
}
a[name], a[name]:hover, .block {
    color: var(--co-0);
}

div.block {
    font-size: 100%;
}

.contentContainer, main, #MainFlow {
    max-width: 1024px;
    margin-left: 20%;
}

.topNav, .bar {
    background-position: bottom;
}
.subNav, .sub-nav {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}
#footer-banner {
    background-color: inherit !important;
    border: none;
}

h1, h2, h3, h4, h5 {
    color: var(--co-0);
}

.header-container {
    background-color: var(--bg-2);
    border-color: var(--bd-1);
}
#TopBar {
    background: var(--bg-2);
    border-color: var(--bd-1);
}
div.Banner>p {
    background-color: var(--bg-3) !important;
}

.title, #TopBar_left {
    color: var(--co-2);
}
code {
    color: #25a51c;
}
pre {
    color: #fe9c19;
}
a:link, a:visited {
    color: #4b6fd4;
}
a:hover {
    text-decoration: underline;
}

ul.blockList ul.blockList li.blockList,
ul.blockList ul.blockListLast li.blockList,
.summary section[class$="-summary"],
.details section[class$="-details"],
.class-uses .detail,
.serialized-class-details {
    background-color: var(--bg-2);
    border-color: var(--bd-0);
}
ul.blockList ul.blockList ul.blockList li.blockList h3,
th.colFirst, th.colSecond, th.colLast, th.colOne,
.constantValuesContainer th,
div.details ul.blockList ul.blockList ul.blockList li.blockList h4,
div.details ul.blockList ul.blockList ul.blockListLast li.blockList h4,
.table-header,
body.class-declaration-page .summary h3,
body.class-declaration-page .details h3,
body.class-declaration-page .summary .inherited-list h2 {
    background-color: var(--bg-3);
    border-color: var(--bd-1);
}
ul.blockList ul.blockList ul.blockList li.blockList,
ul.blockList ul.blockList ul.blockListLast li.blockList,
.inherited-list, section[class$="-details"] .detail {
    background-color: var(--bg-1);
    border-color: var(--bd-1);
}
.contentContainer table, .classUseContainer table, .constantValuesContainer table,
td.colFirst, th.colFirst, td.colSecond, th.colSecond, td.colOne, th.colOne, td.colLast, th.colLast,
.summary-table, .details-table {
    border-color: var(--bd-1);
}
.rowColor, .rowColor th, .odd-row-color {
    background-color: var(--bg-1);
}
.altColor, .altColor th, .even-row-color {
    background-color: var(--bg-0);
}

.ui-widget-content, ul.ui-autocomplete, ul.ui-autocomplete li.ui-static-link {
    background-color: var(--bg-2);
    color: var(--co-1);
}
.ui-widget.ui-widget-content {
    border-color: var(--bd-1);
}
`],


["mep - WHATWG", {
  domains: [
    "whatwg.org",
  ],
}, `
html, body {
    background-color: var(--bg-1);
}
body {
    color: var(--co-0);
    max-width: 64em;
}

pre>code,
pre>code.idl,
pre.highlight,
pre.idl,
pre > code.idl::before {
    background-color: var(--bg-2);
    color: var(--co-1);
    border-color: var(--bd-1);
}
code, code.idl, c-[g] {
    color: var(--co-1);
}

.note, .domintro {
    color: #DDFFDD;
    background-color: green;
}
.warning {
    color: #FFFFCA;
    background-color: #D50606;
}
.warning::before {
    color: #D50606;
    background-color: yellow;
}
.example {
    background-color: var(--bg-3);
    color: var(--co-1);
}
.element {
    background-color: var(--bg-2);
    color: var(--co-1);
}

:link {
    color: #0052cc;
}
.mdn-anno>.mdn-anno-btn {
    background-color: #000;
}

img {
    filter: invert(.72);
}
`],


["mep - OneDrive", {
  domains: [
    "onedrive.live.com",
    "odwebp.svc.ms",
    "sharepoint.com",
  ],
}, `
:root {
    /* taken from outlook.live's dark theme for consistency,
       hence this is not quite part of "mep" */
    --bg-dark: #0A0A0A;
    --bg-medium: #141414;
    --bg-bright: #292929;
    --bg-item: #292929;
    --bg-hover: #333333;
    --bg-important: #061724;

    --bd-medium: #3D3D3D;
    --bd-highlight: #479EF5;

    --co-dark: #616161;
    --co-medium: #D6D6D6;
    --co-bright: #FFFFFF;
    --co-highlight: #479EF5;
    --co-enabled: #ADADAD;
    --co-disabled: #BDBDBD;
}

body, div#appRoot {
    background-color: var(--bg-medium);
    border-color: var(--bd-medium);
    color: var(--co-medium);
}
h2 {
    color: var(--co-medium) !important;
}

/*- top bar */
.od-TopBar-header * {
    background-color: var(--bg-medium);
}
.od-Files-topBar {
    border-color: var(--bd-medium) !important;
}
a[data-navigationcomponent="SiteHeader"] {
    color: var(--co-bright) !important;
}
a[data-navigationcomponent="SiteHeader"]>img {
    filter: invert(.92);
}
.od-TopBar-commandBar {
    border-color: var(--bd-medium) !important;
}
.od-TopBar-item {
    background-color: var(--bd-medium);
}
/*-*/

.sp-appBar {
    background-color: var(--bg-dark);
    border-color: var(--bd-medium) !important;
}

/*- left side nav */
.ms-Nav-compositeLink,
.SPOApp .LeftPane,
.od-LeftNav-navContent {
    background-color: var(--bg-medium);
}
.ms-Nav-compositeLink .ms-Nav-link:focus,
.ms-Nav-compositeLink .ms-Nav-link:hover,
.isFluentVNext div[class^="pane"] .ms-Nav-compositeLink.is-selected .ms-Nav-link:focus,
.isFluentVNext div[class^="pane"] .ms-Nav-compositeLink.is-selected .ms-Nav-link:hover {
    background-color: var(--bg-hover);
    color: var(--co-bright);
}
[dir="ltr"] .isFluentVNext .od-LeftNav:not(.od-LeftNav--expanded),
html[dir="ltr"] .Files-leftNav,
.ms-Nav-group,
.LeftNav-notificationLink,
.LeftNav-subLinkWarningText,
.LeftPane--hasNotifications .LeftPane-notifications {
    border-color: var(--bd-medium) !important;
}
div[class^="groupHeader"] {
    color: var(--co-bright);
}
a.ms-Nav-link,
.isFluentVNext div[class^="pane"] .ms-Nav-compositeLink.is-selected .ms-Nav-link,
.isFluentVNext span[class^="iconWrapper"] i {
    color: var(--co-medium);
}
.isFluentVNext .od-PremiumUpsellBanner-header {
    background-color: var(--bg-important);
}
.isFluentVNext .od-PremiumUpsellBanner-header:hover {
    background-color: var(--bg-hover);
}
/*-*/

.isFluentVNext div[class^="core"],
.isFluentVNext div[class^="commandBar"] {
    background-color: var(--bg-medium);
}

.ms-MessageBar {
    background-color: var(--bg-bright);
    color: var(--co-medium);
}
.ms-MessageBar-dismissal .ms-Button-icon {
    color: var(--co-medium);
}

.ms-Breadcrumb-item {
    color: var(--co-medium) !important;
}
.ms-Breadcrumb-itemLink:hover {
    background-color: var(--bg-bright);
    color: var(--co-medium);
}
.ms-Breadcrumb-itemLink:focus {
    color: var(--co-dark);
}

.ms-Shimmer-container {
    filter: invert(.92);
}
.ms-List::after {
    background-image: none;
}

/*- file list */
.Files-mainColumn,
.File-search-expand,
.od-ItemContent-header,
.od-ItemContent-header {
    background-color: var(--bg-medium) !important;
}
a[class^="tileViewport"],
.ms-DetailsList {
    background-color: var(--bg-item) !important;
    box-shadow: 0px 2px 4px var(--bd-medium), 0px 0px 2px var(--bd-medium) !important;
}

#odList,
.ms-DetailsList-headerWrapper .ms-DetailsHeader {
    background-color: var(--bg-bright);
    border-color: var(--bd-medium);
}
.ms-DetailsHeader-cell {
    color: var(--co-medium);
}
.ms-DetailsHeader-cell:hover {
    background-color: var(--bg-hover);
    color: var(--co-bright);
}

.ms-SelectionZone .ms-List-cell .ms-DetailsRow {
    background-color: var(--bg-item);
    color: var(--co-medium);
}
.ms-SelectionZone .ms-List-cell .ms-DetailsRow:hover {
    background-color: var(--bg-hover);
}
.ms-SelectionZone .ms-List-cell .ms-DetailsRow.is-selected {
    background-color: var(--bg-important);
}

a[class^="tileViewport"] span[style] {
    color: var(--co-medium) !important;
}
.ms-DetailsRow-cell .ms-Link[class*="nameField"],
.ms-DetailsRow-cell .ms-Link[class*="nameField"]:focus,
.ms-DetailsRow-cell .ms-Link[class*="nameField"]:visited,
.ms-DetailsRow-cell div[class*="nameField"] {
    color: var(--co-bright);
}
.ms-DetailsRow-cell .ms-Link[class*="nameField"][class*="clickable"]:hover,
.ms-DetailsRow.is-selected .ms-DetailsRow-cell .ms-Link[class*="nameField"]:hover {
    color: var(--co-highlight);
}
.ms-FocusZone[class*=root] {
    border-color: var(--bd-medium) !important;
}
div[class*="isSelected"]::before {
    border-color: var(--bg-item) !important;
}

.heroButton_e5e31e1b:hover {
    background-color: var(--bg-bright);
}

.SPOApp:not(.od-Browser--ie) .od-ItemsScopeList-content .ms-DetailsHeader,
.SPOApp:not(.od-Browser--ie) .od-ItemsScopeList-content .od-filtersHeader {
    box-shadow: none;
}
/*-*/

/*- file hover */
.ms-ExpandingCard-compactCard,
.ms-ExpandingCard-expandedCard,
.ms-ExpandingCard-expandedCard>div>div>div>div,
.ms-ActivityItem * {
    color: var(--co-medium);
}
/*-*/

/*- file details right side */
.od-DetailsPane,
.od-DetailsPane-PrimaryPane-wrapper {
    background-color: var(--bg-bright);
}
.od-DetailsPane-PrimaryPane-header,
.od-SharingSection-PermissionsPile,
.od-DetailsPane-LegacySection .InfoPane-section,
.od-DetailsPane-SecondaryPane-wrapper {
    background-color: var(--bg-medium);
}
.od-DetailsPane-SecondaryPane-body {
    background-color: var(--bg-bright);
}
.od-DetailsPane-SecondaryPane .od-DetailsPane-ItemActivityFeedSection-content .od-ItemActivityFeed-error,
.od-DetailsPane-SecondaryPane .od-DetailsPane-ItemActivityFeedSection-content .od-ItemActivityFeed-noActivities,
.od-DetailsPane-SecondaryPane .od-DetailsPane-ItemActivityFeedSection-content .od-ItemActivityList-activity {
    background-color: var(--bg-medium);
}
.od-DetailsPaneWrapper {
    border-color: var(--bg-dark) !important;
}
.od-DetailsPaneWrapper,
.Files-rightPane,
.od-Resize,
.od-InfoPane-ReactSections .InfoPane-section {
    background-color: var(--bg-dark);
}
.od-DetailsPane-SecondaryPane-header,
.od-DetailsPane-SecondaryPane {
    box-shadow: none;
    background-color: var(--bg-dark);
}
.InfoPane-sectionHeaderText,
.od-ItemActivityFeed-title-old {
    color: var(--co-medium);
}
/*-*/

/*- "command bar" */
.ms-Button,
.ms-CommandBar {
    background-color: var(--bg-bright) !important;
}
.ms-CommandBar .ms-Button {
    color: var(--co-medium) !important;
}
.ms-CommandBar .ms-Button:hover * {
    background-color: var(--bg-hover) !important;
}
.ms-CommandBar .ms-Button:hover i.ms-Button-menuIcon {
    color: var(--co-brigth);
}
.isFluentVNext div[class^="commandBar"] .ms-CommandBar::after {
    content: none;
}
/*-*/

/*- various other dialogs/popups */
.ms-Panel .ms-Panel-main,
.ms-Panel .ms-Panel-commands,
.ms-Dialog .ms-Dialog-main,
.ms-Callout .ms-Callout-main,
.ms-ContextualMenu-container .ms-FocusZone {
    background-color: var(--bg-bright);
}
.ms-Panel .ms-Panel-commands .ms-Panel-navigation div,
.ms-Dialog .ms-Dialog-title,
.ms-ProgressIndicator .ms-ProgressIndicator-itemName,
.ms-Button-label {
    color: var(--co-medium);
}
.ms-Dialog .ms-Dialog-subText,
.ms-ContextualMenu-itemText {
    color: var(--co-bright);
}
.ms-ContextualMenu-divider,
.ms-ContextualMenu-link:hover {
    background-color: var(--bd-medium);
}
/*-*/

/*- viewer (pdf) */
.OneUp,
.OneUp--hasCommandBar .OneUp-commandBar {
    background-color: var(--bg-medium) !important;
    border-color: var(--bg-medium) !important;
}
.OneUp-caption-container {
    background-color: var(--bg-bright);
}
.OneUp-caption {
    color: var(--co-medium);
}
/* TODO: .OneUp-infoPane */
/*-*/

/*- "move to" window */
.isFluentVNext .od-FilePickerApp {
    background-color: var(--bg-medium);
}
.isFluentVNext .od-FilePicker-navPane {
    background-color: var(--bg-dark);
    border-color: var(--bd-medium) !important;
}
.isFluentVNext .od-FilePicker-navPane h1 {
    color: var(--co-medium);
}
.isFluentVNext .od-FilePicker-tray {
    background-color: var(--bg-bright);
    border-color: var(--bd-medium);
}
/*-*/
`],


["mep - GNU Classpath", {
  domains: [
    "developer.classpath.org",
  ],
}, `
body {
    background: var(--bg-1);
    color: var(--co-1);
}
.content {
    max-width: 850px;
    padding-left: 23%;
}

.navbar.item {
    border-color: var(--bd-1);
}
.navbar.item.disabled {
    color: var(--bg-3);
    border-color: var(--bg-3);
}
.navbar.item.active, .title,
.table.header, .table.sub.header, .section.header:not(.tag), .serialized.package.header, .serialized.class.header {
    background: #393e7a;
    color: var(--co-0);
    border-color: var(--bd-0);
}

.table.container tr {
    background: var(--bg-2);
}
.table.container tr:nth-child(odd) {
    background: var(--bg-0);
}
.table.container tr:first-of-type {
    background: #393e7a;
}
table, td, .title, .class.title.outer {
    border-color: var(--bd-0);
}

a[href], a[href]:visited {
    color: #4b6fd4;
}

.header.type { color: #446ce3; }
.type { color: #438cf4; }
.quote { color: #ed5fd5; }
`],


["mep - registry.khronos.org", {
  domains: [
    "registry.khronos.org",
  ],
}, `
body {
    background-color: var(--bg-1);
    color: var(--co-0);
    max-width: 850px;
    padding-left: calc(50% - 450px);
}

h2 {
    color: var(--co-1);
}

div.funcsynopsis,
div.funcsynopsis * {
    background-color: var(--bg-2) !important;
    color: var(--co-2);
}

div.refsect1 table,
div.refsect1 table * {
    background-color: var(--bg-2);
    border-color: var(--bd-0) !important;
    color: var(--co-1);
}

a {
    color: #0052cc !important;
}

a:visited {
    color: #164182 !important;
}
`],

["mep - Office MHComm", {
  domains: [
    "office.mhcomm.fr",
    "cloud.mhcomm.fr",
    "docs.mhcomm.fr",
  ],
}, `
html {
    scrollbar-color: initial;
}
body {
    background-color: var(--bg-0);
    color: var(--co-1);
}

#root input {
    border-color: var(--bd-1);
}
#root div>input+div {
    background-color: var(--bg-1);
}
#root kbd {
    background-color: var(--bg-2);
    border-color: var(--bd-0);
}
`],


["mep - graphviz", {
  domains: [
    "graphviz.org",
  ],
}, `
body {
    background-color: var(--bg-1);
    color: var(--co-1);
}

img {
    filter: invert(.8);
}

/*- side-nav/outer */
.td-sidebar-nav__section-title a,
.td-sidebar-nav .td-sidebar-link__page,
.text-body-secondary,
.td-page-meta__lastmod {
    color: var(--co-1) !important;
}

.td-sidebar,
.form-control,
.td-sidebar-toc,
.border-top,
.td-page-meta__lastmod {
    border-color: var(--bd-1) !important;
}
/*-*/

/*- code/pre */
code,
.card,
.card-header {
    background-color: var(--bg-2) !important;
    color: var(--co-2) !important;
}
.card.border {
    border: none !important;
}

code[class*="language-"],
pre[class*="language-"],
.td-content pre {
    background-color: var(--bg-0) !important;
    color: var(--co-0);
    border-color: var(--bd-0);
    text-shadow: none;
}
.token {
    background-color: initial !important;
}
/*-*/

/*- tables */
.table > :not(caption) > * > *,
.td-table:not(.td-initial) > :not(caption) > * > *,
.td-content table:not(.td-initial) > :not(caption) > * > *,
.td-box table:not(.td-initial) > :not(caption) > * > * {
    background-color: var(--bg-0);
    color: var(--co-0);
    border-color: var(--bd-0);
}
/*-*/
`],


["mep - SQLite.org", {
  domains: [
    "sqlite.org",
  ],
}, `
body {
    background-color: var(--bg-1);
    color: var(--co-1);
}

.fancy_title,
.fancy_toc>summary,
.fancy h1, .fancy h2, .fancy h3, .fancy h4 {
    color: #76a6b8;
}

.fancy .codeblock, .yyterm {
    background-color: var(--bg-2);
    color: var(--co-2);
}

a, a:visited {
    color: #32b0ff;
}

table, tbody, th, td {
    border-color: var(--bd-1);
}

@media only screen and (min-width: 780px) {
    body {
        padding: 1vh 20vw 1vh 5vw;
    }
}

@media only screen and (min-width: 900px) {
    body {
        padding: 1vh 1vw 1vh 1vw;
    }
}

@media only screen and (min-width: 1200px) {
    body {
        padding: 1vh 25vw 1vh 20vw;
    }
}

svg>* {
    fill: var(--bd-1);
    stroke: var(--bd-1) !important;
}
svg>polygon {
    fill: var(--bd-1) !important;
}
`],

];} if ('process' in globalThis && 2 < process.argv.length)
    if ('-h' == process.argv[2] || '--help' == process.argv[2]) console.log("Usage: $0 [<in-stylus.json>]");
    else for (const it of JSON.parse(require('fs').readFileSync(process.argv[2])).filter(it => 'sections' in it)) for (const se of it.sections) {
        console.log(`["${it.name}", {`);
        for (const ppt of ['domains', 'regexps', 'urlPrefixes']) if (ppt in se)
            console.log(`  ${ppt}: [\n    ${se[ppt].map(JSON.stringify).join(',\n    ')},\n  ],`);
        console.log(`}, \`\n${se.code.replace(/\\/g, '\\\\')}\`],\n\n`);
    }
else console.log(JSON.stringify([{settings:{'editor.keyMap':'vim','hotkey.styleDisableAll':'Alt+Y'}}].concat(list().map(([name, target, code], id) => ({
    id,
    name,
    enabled: true,
    sections: [{ code: code.slice(1), ...target }]
}))), undefined, 2));
