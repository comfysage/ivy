# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  bqf = {
    pname = "bqf";
    version = "dd17c73912487dccb372deff85d4262d2b89bc2b";
    src = fetchFromGitHub {
      owner = "kevinhwang91";
      repo = "nvim-bqf";
      rev = "dd17c73912487dccb372deff85d4262d2b89bc2b";
      fetchSubmodules = false;
      sha256 = "sha256-WJrTOqqO4w9YRErTr6rGb8RxJA+HxKaZGlV2mGl64GM=";
    };
    date = "2025-07-20";
  };
  catppuccin = {
    pname = "catppuccin";
    version = "82f3dcedc9acc242d2d4f98abca02e2f10a75248";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "nvim";
      rev = "82f3dcedc9acc242d2d4f98abca02e2f10a75248";
      fetchSubmodules = false;
      sha256 = "sha256-gp+UuRkGHLn/GuKW3zQphNQnq8OLXRP4weo1oOUTuI8=";
    };
    as = "catppuccin";
    date = "2025-07-22";
  };
  chai-nvim = {
    pname = "chai-nvim";
    version = "5b3142493114ade681dfad63417e5989c11f0f6d";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "chai.nvim";
      rev = "5b3142493114ade681dfad63417e5989c11f0f6d";
      fetchSubmodules = false;
      sha256 = "sha256-T2KHSYdRNbqAPpZrzzRBkTmhS8YV1eiHfnRR1QG5D9k=";
    };
    as = "chai";
    start = "true";
    date = "2025-03-21";
  };
  cloak = {
    pname = "cloak";
    version = "648aca6d33ec011dc3166e7af3b38820d01a71e4";
    src = fetchFromGitHub {
      owner = "laytan";
      repo = "cloak.nvim";
      rev = "648aca6d33ec011dc3166e7af3b38820d01a71e4";
      fetchSubmodules = false;
      sha256 = "sha256-V7oNIu7IBAHqSrgCNoePNUPjQDU9cFThFf7XGIth0sk=";
    };
    date = "2024-06-12";
  };
  crates = {
    pname = "crates";
    version = "c915ab5334a46178f64ce17ab606a79454bcd14f";
    src = fetchFromGitHub {
      owner = "saecki";
      repo = "crates.nvim";
      rev = "c915ab5334a46178f64ce17ab606a79454bcd14f";
      fetchSubmodules = false;
      sha256 = "sha256-5Vu3VG6Ab1Rpqzeqoa0S9sfzco7wykrSt2eSXOajm14=";
    };
    date = "2025-07-22";
  };
  direnv = {
    pname = "direnv";
    version = "4dfc8758a1deab45e37b7f3661e0fd3759d85788";
    src = fetchFromGitHub {
      owner = "NotAShelf";
      repo = "direnv.nvim";
      rev = "4dfc8758a1deab45e37b7f3661e0fd3759d85788";
      fetchSubmodules = false;
      sha256 = "sha256-KqO8uDbVy4sVVZ6mHikuO+SWCzWr97ZuFRC8npOPJIE=";
    };
    date = "2025-06-09";
  };
  evergarden = {
    pname = "evergarden";
    version = "27d2c7a1182f08ea17fd86b24c9833040373e89b";
    src = fetchFromGitHub {
      owner = "everviolet";
      repo = "nvim";
      rev = "27d2c7a1182f08ea17fd86b24c9833040373e89b";
      fetchSubmodules = false;
      sha256 = "sha256-GtlJUgz+4n5fDIWUT7gDltj5kpK2W+zwchm3vwHVDcM=";
    };
    as = "evergarden";
    date = "2025-07-18";
  };
  fidget = {
    pname = "fidget";
    version = "2f7c08f45639a64a5c0abcf67321d52c3f499ae6";
    src = fetchFromGitHub {
      owner = "j-hui";
      repo = "fidget.nvim";
      rev = "2f7c08f45639a64a5c0abcf67321d52c3f499ae6";
      fetchSubmodules = false;
      sha256 = "sha256-8Gl2Ck4YJGReSEq1Xeh1dpdRq4eImmrxvIHrfxdem3Q=";
    };
    date = "2023-11-09";
  };
  freeze = {
    pname = "freeze";
    version = "590fdb0d724485f578e4fee0e3ae2b32040dfb1a";
    src = fetchFromGitHub {
      owner = "charm-community";
      repo = "freeze.nvim";
      rev = "590fdb0d724485f578e4fee0e3ae2b32040dfb1a";
      fetchSubmodules = false;
      sha256 = "sha256-VdFmSRBP7Up0j5+rp7ZkfTdQmduJjsl6EZ9gf27vgZg=";
    };
    date = "2025-03-25";
  };
  fzf-lua = {
    pname = "fzf-lua";
    version = "3b45f14ac0f3f76782c107f13180eb87e96122fc";
    src = fetchFromGitHub {
      owner = "ibhagwan";
      repo = "fzf-lua";
      rev = "3b45f14ac0f3f76782c107f13180eb87e96122fc";
      fetchSubmodules = false;
      sha256 = "sha256-0XBRYE8dCmIqkq5HYkTaI0TBWbBDih62ubm/IGjFJZE=";
    };
    date = "2025-07-21";
  };
  hunk-nvim = {
    pname = "hunk-nvim";
    version = "1e0a4d719c780bb8b0690a54915601508ced321e";
    src = fetchFromGitHub {
      owner = "julienvincent";
      repo = "hunk.nvim";
      rev = "1e0a4d719c780bb8b0690a54915601508ced321e";
      fetchSubmodules = false;
      sha256 = "sha256-va7cCBuBk3WLAZjKl+lxlKmVckaK010RAdWMzrXlzAw=";
    };
    date = "2025-06-09";
  };
  img-clip-nvim = {
    pname = "img-clip-nvim";
    version = "d8b6b030672f9f551a0e3526347699985a779d93";
    src = fetchFromGitHub {
      owner = "HakonHarnes";
      repo = "img-clip.nvim";
      rev = "d8b6b030672f9f551a0e3526347699985a779d93";
      fetchSubmodules = false;
      sha256 = "sha256-6hpSJbrJEnw5NaVkGrXxXeqkObNTUPCtKJd+iZBFUM0=";
    };
    date = "2025-06-08";
  };
  indent-blankline = {
    pname = "indent-blankline";
    version = "005b56001b2cb30bfa61b7986bc50657816ba4ba";
    src = fetchFromGitHub {
      owner = "lukas-reineke";
      repo = "indent-blankline.nvim";
      rev = "005b56001b2cb30bfa61b7986bc50657816ba4ba";
      fetchSubmodules = false;
      sha256 = "sha256-0q/V+b4UrDRnaC/eRWOi9HU9a61vQSAM9/C8ZQyKt+Y=";
    };
    date = "2025-03-18";
  };
  keymaps-nvim = {
    pname = "keymaps-nvim";
    version = "221a1015f5c5f2530379983e1dc200a202f487dd";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "keymaps.nvim";
      rev = "221a1015f5c5f2530379983e1dc200a202f487dd";
      fetchSubmodules = false;
      sha256 = "sha256-afMAPHITrHKxHQKd64goFUncfbKH81t6Xyh5pFCiSTg=";
    };
    date = "2025-03-17";
  };
  lsp-status = {
    pname = "lsp-status";
    version = "54f48eb5017632d81d0fd40112065f1d062d0629";
    src = fetchFromGitHub {
      owner = "nvim-lua";
      repo = "lsp-status.nvim";
      rev = "54f48eb5017632d81d0fd40112065f1d062d0629";
      fetchSubmodules = false;
      sha256 = "sha256-gmLeVnDyL8Zf5ZG92tP3mb/LAt438BxFtAi/Xax2zLI=";
    };
    date = "2022-08-03";
  };
  lualine = {
    pname = "lualine";
    version = "a94fc68960665e54408fe37dcf573193c4ce82c9";
    src = fetchFromGitHub {
      owner = "nvim-lualine";
      repo = "lualine.nvim";
      rev = "a94fc68960665e54408fe37dcf573193c4ce82c9";
      fetchSubmodules = false;
      sha256 = "sha256-2aPgA7riA/FubQpTkqsxLKl7OZ8L6FkucNHc2QEx2HQ=";
    };
    date = "2025-06-08";
  };
  lz-n = {
    pname = "lz-n";
    version = "43b646cfd8e2a0e3963f620a5f6447b3dd5d4678";
    src = fetchFromGitHub {
      owner = "nvim-neorocks";
      repo = "lz.n";
      rev = "43b646cfd8e2a0e3963f620a5f6447b3dd5d4678";
      fetchSubmodules = false;
      sha256 = "sha256-KqJYHXUknKkbNYqP8M1QE73VcHZU+DFe4gAt+EqXS6g=";
    };
    start = "true";
    date = "2025-07-20";
  };
  markit-nvim = {
    pname = "markit-nvim";
    version = "6dc7f4c4f09f40fdf8d01f81a99518db2a4efa2d";
    src = fetchFromGitHub {
      owner = "2KAbhishek";
      repo = "markit.nvim";
      rev = "6dc7f4c4f09f40fdf8d01f81a99518db2a4efa2d";
      fetchSubmodules = false;
      sha256 = "sha256-u0EDzOsxArKBi+drg2bhCQJNc0riRfkLVPgwmTZ0750=";
    };
    date = "2025-07-21";
  };
  markview = {
    pname = "markview";
    version = "ec33f2aa333ca1d76f51847922578434d7aeadf7";
    src = fetchFromGitHub {
      owner = "OXY2DEV";
      repo = "markview.nvim";
      rev = "ec33f2aa333ca1d76f51847922578434d7aeadf7";
      fetchSubmodules = false;
      sha256 = "sha256-mjofgl6B+NcvYFwRY1q2zeOMgiRGeV52dR0LzFhDhQ0=";
    };
    date = "2025-07-16";
  };
  mini-ai = {
    pname = "mini-ai";
    version = "1cd4f021a05c29acd4ab511c0981da14217daf38";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.ai";
      rev = "1cd4f021a05c29acd4ab511c0981da14217daf38";
      fetchSubmodules = false;
      sha256 = "sha256-m8uwB+SUMJylnx6pcnu+0oPsNKihWgUhjcGNhSwRrhA=";
    };
    date = "2025-07-22";
  };
  mini-align = {
    pname = "mini-align";
    version = "0202e1662a7a03a95cefd6851795ceae5e87b9b3";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.align";
      rev = "0202e1662a7a03a95cefd6851795ceae5e87b9b3";
      fetchSubmodules = false;
      sha256 = "sha256-xdEh6mh4VQky3b0RziMR6DEjbTdLvLDQQGMTX7rP/Hs=";
    };
    date = "2025-07-22";
  };
  mini-bracketed = {
    pname = "mini-bracketed";
    version = "4a005a6e5aad58230b69f0f59df2cbb8b1c2e643";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.bracketed";
      rev = "4a005a6e5aad58230b69f0f59df2cbb8b1c2e643";
      fetchSubmodules = false;
      sha256 = "sha256-fd110tEpwATu0mKSMlDcnNdHShMCOD1uIYwYYDAj4nE=";
    };
    date = "2025-07-22";
  };
  mini-diff = {
    pname = "mini-diff";
    version = "f573bd2ae2eb225ea2f125126b8869e04bcaf231";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.diff";
      rev = "f573bd2ae2eb225ea2f125126b8869e04bcaf231";
      fetchSubmodules = false;
      sha256 = "sha256-F4GEO052skNlt5vaFr/AH4QHw28T9rAIEbynzaeBimY=";
    };
    date = "2025-07-22";
  };
  mini-files = {
    pname = "mini-files";
    version = "5b9431cf5c69b8e69e5a67d2d12338a3ac2e1541";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.files";
      rev = "5b9431cf5c69b8e69e5a67d2d12338a3ac2e1541";
      fetchSubmodules = false;
      sha256 = "sha256-TA/lf25tto5/w8H/envfOkXuHSNdZj/wCftSeMLkYvg=";
    };
    date = "2025-07-22";
  };
  mini-git = {
    pname = "mini-git";
    version = "c38380e1a6582b1aee7de26e9738b1ce17366d7d";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini-git";
      rev = "c38380e1a6582b1aee7de26e9738b1ce17366d7d";
      fetchSubmodules = false;
      sha256 = "sha256-iNW20Fo3k9Dld9Stk0gOvoUDGTawZPj07kgfrFmKboc=";
    };
    date = "2025-07-22";
  };
  mini-icons = {
    pname = "mini-icons";
    version = "1d91152ae9913e148c3e330ce2c921cf4f36995f";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.icons";
      rev = "1d91152ae9913e148c3e330ce2c921cf4f36995f";
      fetchSubmodules = false;
      sha256 = "sha256-bKSQX5YNILl5krGbfSFB6vACNJI99xOWLyYsnX0qwwE=";
    };
    date = "2025-07-22";
  };
  mini-move = {
    pname = "mini-move";
    version = "819e90c3e113a3c826c3003ec07073f1e0677ea0";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.move";
      rev = "819e90c3e113a3c826c3003ec07073f1e0677ea0";
      fetchSubmodules = false;
      sha256 = "sha256-yoRat9jaTgTos7t0UHDQLyGoH64Ijwn7LsCYGkenbrU=";
    };
    date = "2025-07-22";
  };
  mini-operators = {
    pname = "mini-operators";
    version = "fd655907ed56434c83a6efb654b266d9c090ca82";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.operators";
      rev = "fd655907ed56434c83a6efb654b266d9c090ca82";
      fetchSubmodules = false;
      sha256 = "sha256-TGp8QDPDpCH+fBzghFDo9neMB83o/t3gyDm/V4dofrg=";
    };
    date = "2025-07-22";
  };
  mini-pairs = {
    pname = "mini-pairs";
    version = "1e1ca3f60f58d4050bf814902b472eec9963a5dd";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.pairs";
      rev = "1e1ca3f60f58d4050bf814902b472eec9963a5dd";
      fetchSubmodules = false;
      sha256 = "sha256-BcKyjylmbmUt6xF0hX7bNQWa56x+TWbHjVOvmzz3m/8=";
    };
    date = "2025-07-22";
  };
  mini-splitjoin = {
    pname = "mini-splitjoin";
    version = "51909e9883ab206f5a92deb9ca685317387586a4";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.splitjoin";
      rev = "51909e9883ab206f5a92deb9ca685317387586a4";
      fetchSubmodules = false;
      sha256 = "sha256-GUDaXslLbBdxLfIwKEwDI7LSf0GB9Etm3v0347bwN+c=";
    };
    date = "2025-07-22";
  };
  mini-surround = {
    pname = "mini-surround";
    version = "b12fcfefd6b9b7c9e9a773bc0e3e07ae20c03351";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.surround";
      rev = "b12fcfefd6b9b7c9e9a773bc0e3e07ae20c03351";
      fetchSubmodules = false;
      sha256 = "sha256-jmxdD9rrVocOczkOkyRICfD/B6SiD1glsxnIALFR/ww=";
    };
    date = "2025-07-22";
  };
  mini-trailspace = {
    pname = "mini-trailspace";
    version = "3d570d015d63ad6d3f8a90f12c6b544c2400cea9";
    src = fetchFromGitHub {
      owner = "echasnovski";
      repo = "mini.trailspace";
      rev = "3d570d015d63ad6d3f8a90f12c6b544c2400cea9";
      fetchSubmodules = false;
      sha256 = "sha256-xEnpOx8erDuHUC34d6trDCFukr4oRqUbybBPTqjNefc=";
    };
    date = "2025-07-22";
  };
  mossy-nvim = {
    pname = "mossy-nvim";
    version = "1bbe62b732ef9dde75225e1ae4676142dbea2286";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "mossy.nvim";
      rev = "1bbe62b732ef9dde75225e1ae4676142dbea2286";
      fetchSubmodules = false;
      sha256 = "sha256-vzGyD1R92vasgzyDGfkaAgrd3rMmxUpVbamhxoGaCBY=";
    };
    date = "2025-06-08";
  };
  neo-tree = {
    pname = "neo-tree";
    version = "b85cc7611ff8fb443b0a1591c53669ead195a826";
    src = fetchFromGitHub {
      owner = "nvim-neo-tree";
      repo = "neo-tree.nvim";
      rev = "b85cc7611ff8fb443b0a1591c53669ead195a826";
      fetchSubmodules = false;
      sha256 = "sha256-vsujCQX7yOSiwzxlN0g8OIsQqm/o897kBL42rAmyzCU=";
    };
    date = "2025-07-17";
  };
  neogen = {
    pname = "neogen";
    version = "d7f9461727751fb07f82011051338a9aba07581d";
    src = fetchFromGitHub {
      owner = "danymat";
      repo = "neogen";
      rev = "d7f9461727751fb07f82011051338a9aba07581d";
      fetchSubmodules = false;
      sha256 = "sha256-uXV8YZLO44lFys1RfIqsvonC2YEYwb1iiaiLfsON3hE=";
    };
    date = "2025-05-03";
  };
  nui = {
    pname = "nui";
    version = "de740991c12411b663994b2860f1a4fd0937c130";
    src = fetchFromGitHub {
      owner = "MunifTanjim";
      repo = "nui.nvim";
      rev = "de740991c12411b663994b2860f1a4fd0937c130";
      fetchSubmodules = false;
      sha256 = "sha256-41slmnvt1z7sCxvpiVuFmQ9g7eCaxQi1dDCL3AxSL1A=";
    };
    date = "2025-06-08";
  };
  nvim-colorizer = {
    pname = "nvim-colorizer";
    version = "16597180b4dd81fa3d23d88c4d2f1b49154f9479";
    src = fetchFromGitHub {
      owner = "nvchad";
      repo = "nvim-colorizer.lua";
      rev = "16597180b4dd81fa3d23d88c4d2f1b49154f9479";
      fetchSubmodules = false;
      sha256 = "sha256-xj+FwjgeQ83VT/D8EeQn1ieA+fWS5910mRskTvI5mDo=";
    };
    date = "2025-07-22";
  };
  nvim-lint = {
    pname = "nvim-lint";
    version = "9c6207559297b24f0b7c32829f8e45f7d65b991f";
    src = fetchFromGitHub {
      owner = "mfussenegger";
      repo = "nvim-lint";
      rev = "9c6207559297b24f0b7c32829f8e45f7d65b991f";
      fetchSubmodules = false;
      sha256 = "sha256-ly5S0KAZN8Jeag22SCX+5XKqn3d+zCRN/8Jf5HlEn9I=";
    };
    date = "2025-07-20";
  };
  nvim-lspconfig = {
    pname = "nvim-lspconfig";
    version = "f47cd681d7cb6048876a2e908b6d8ba1e530d152";
    src = fetchFromGitHub {
      owner = "neovim";
      repo = "nvim-lspconfig";
      rev = "f47cd681d7cb6048876a2e908b6d8ba1e530d152";
      fetchSubmodules = false;
      sha256 = "sha256-dr5zHWzlfUd4lSUZbqbWa9Fg/hPnN4tCnmHdKvO07nY=";
    };
    start = "true";
    date = "2025-07-19";
  };
  nvim-nio = {
    pname = "nvim-nio";
    version = "21f5324bfac14e22ba26553caf69ec76ae8a7662";
    src = fetchFromGitHub {
      owner = "nvim-neotest";
      repo = "nvim-nio";
      rev = "21f5324bfac14e22ba26553caf69ec76ae8a7662";
      fetchSubmodules = false;
      sha256 = "sha256-eDbzJAGdUBhTwuD0Nt9FihZj1MmVdQfn/GKIybuu5a8=";
    };
    date = "2025-01-20";
  };
  nvim-treesitter = {
    pname = "nvim-treesitter";
    version = "40cca05b40438ddd74125132b0cec58c9afdccb2";
    src = fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter";
      rev = "40cca05b40438ddd74125132b0cec58c9afdccb2";
      fetchSubmodules = false;
      sha256 = "sha256-UjGjH2oxM3i40+w4eZ0Q8AHij9rplpfWIrkYmeoCVds=";
    };
    start = "true";
    date = "2025-07-22";
  };
  plenary = {
    pname = "plenary";
    version = "857c5ac632080dba10aae49dba902ce3abf91b35";
    src = fetchFromGitHub {
      owner = "nvim-lua";
      repo = "plenary.nvim";
      rev = "857c5ac632080dba10aae49dba902ce3abf91b35";
      fetchSubmodules = false;
      sha256 = "sha256-8FV5RjF7QbDmQOQynpK7uRKONKbPRYbOPugf9ZxNvUs=";
    };
    start = "true";
    date = "2025-02-11";
  };
  quill-nvim = {
    pname = "quill-nvim";
    version = "08103ea02643a93065fe7dbc4ed22275719fc338";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "quill.nvim";
      rev = "08103ea02643a93065fe7dbc4ed22275719fc338";
      fetchSubmodules = false;
      sha256 = "sha256-SDMoqQwY3cKj5c5wHFdE+G0ZWVIeLjF6DU67tfDfi8w=";
    };
    date = "2024-12-10";
  };
  rainbow-delimiters = {
    pname = "rainbow-delimiters";
    version = "49372aadaaf04d14a50efaa34150c51d5a8047e1";
    src = fetchFromGitHub {
      owner = "hiphish";
      repo = "rainbow-delimiters.nvim";
      rev = "49372aadaaf04d14a50efaa34150c51d5a8047e1";
      fetchSubmodules = false;
      sha256 = "sha256-qvYpFcqLJ/DCdgGUaeaEOna9J9Rcsnj98OQr1ioINiI=";
    };
    date = "2025-07-20";
  };
  rustaceanvim = {
    pname = "rustaceanvim";
    version = "628ff0137003d2ff245a06aff101142a5c88391e";
    src = fetchFromGitHub {
      owner = "mrcjkb";
      repo = "rustaceanvim";
      rev = "628ff0137003d2ff245a06aff101142a5c88391e";
      fetchSubmodules = false;
      sha256 = "sha256-CTkXGLEY52mx5cgPXc/SbI9bEfH3D2rO5A4GxUgGBLo=";
    };
    date = "2025-07-20";
  };
  sayama-nvim = {
    pname = "sayama-nvim";
    version = "39175a766dfc80324d3130d27c3e7922f826226e";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "sayama.nvim";
      rev = "39175a766dfc80324d3130d27c3e7922f826226e";
      fetchSubmodules = false;
      sha256 = "sha256-Rxjg6RvcN5JOP5CTv7Jj7AQJv36zRMaHiFEwhiBVgfw=";
    };
    date = "2024-05-30";
  };
  schemastore = {
    pname = "schemastore";
    version = "c957914d75b4a008ce09f4116e57e59fe6e3fae1";
    src = fetchFromGitHub {
      owner = "b0o";
      repo = "schemastore.nvim";
      rev = "c957914d75b4a008ce09f4116e57e59fe6e3fae1";
      fetchSubmodules = false;
      sha256 = "sha256-5qXEd44NyFGCN4LC2NNK7OO62diykpTARhNK6kGERzw=";
    };
    date = "2025-07-16";
  };
  shelf-nvim = {
    pname = "shelf-nvim";
    version = "cce4c97d23ffca6817fd146310aa5e936f5884f5";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "shelf.nvim";
      rev = "cce4c97d23ffca6817fd146310aa5e936f5884f5";
      fetchSubmodules = false;
      sha256 = "sha256-7DTY7C0wWyL2aA53Y6wYZJDzQpiuq6Mgzr1ecW7VaGY=";
    };
    date = "2025-06-11";
  };
  snacks-nvim = {
    pname = "snacks-nvim";
    version = "bc0630e43be5699bb94dadc302c0d21615421d93";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "snacks.nvim";
      rev = "bc0630e43be5699bb94dadc302c0d21615421d93";
      fetchSubmodules = false;
      sha256 = "sha256-Gw0Bp2YeoESiBLs3NPnqke3xwEjuiQDDU1CPofrhtig=";
    };
    date = "2025-03-01";
  };
  symbol-usage = {
    pname = "symbol-usage";
    version = "e07c07dfe7504295a369281e95a24e1afa14b243";
    src = fetchFromGitHub {
      owner = "Wansmer";
      repo = "symbol-usage.nvim";
      rev = "e07c07dfe7504295a369281e95a24e1afa14b243";
      fetchSubmodules = false;
      sha256 = "sha256-zWT6ZGYGpWLwuUrMlmyTIE5UZtPLX2FnywhycTxUaRQ=";
    };
    date = "2025-05-03";
  };
  tabby-nvim = {
    pname = "tabby-nvim";
    version = "b3affa6db7eab80fca2a2db5b73b473144507039";
    src = fetchFromGitHub {
      owner = "nanozuki";
      repo = "tabby.nvim";
      rev = "b3affa6db7eab80fca2a2db5b73b473144507039";
      fetchSubmodules = false;
      sha256 = "sha256-26ysSn0klZYMPEaxCe/1zD2qCYwobU5dZSq5P/GtwMU=";
    };
    date = "2025-05-23";
  };
  todo-comments = {
    pname = "todo-comments";
    version = "304a8d204ee787d2544d8bc23cd38d2f929e7cc5";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "todo-comments.nvim";
      rev = "304a8d204ee787d2544d8bc23cd38d2f929e7cc5";
      fetchSubmodules = false;
      sha256 = "sha256-at9OSBtQqyiDdxKdNn2x6z4k8xrDD90sACKEK7uKNUM=";
    };
    date = "2025-01-14";
  };
  toggleterm = {
    pname = "toggleterm";
    version = "9a88eae817ef395952e08650b3283726786fb5fb";
    src = fetchFromGitHub {
      owner = "akinsho";
      repo = "toggleterm.nvim";
      rev = "9a88eae817ef395952e08650b3283726786fb5fb";
      fetchSubmodules = false;
      sha256 = "sha256-fytbX+L12TK45YKFU9K+iFJcDrwboKabihc2LtX29J4=";
    };
    date = "2025-03-09";
  };
  treewalker = {
    pname = "treewalker";
    version = "ae229700e1cce34198280f588568dc49c52d9eb1";
    src = fetchFromGitHub {
      owner = "aaronik";
      repo = "treewalker.nvim";
      rev = "ae229700e1cce34198280f588568dc49c52d9eb1";
      fetchSubmodules = false;
      sha256 = "sha256-sBkn56nIlVzxb4UC7/VpQPzYHHc2EdB+lgcIw3YfOQQ=";
    };
    date = "2025-07-16";
  };
  trouble = {
    pname = "trouble";
    version = "85bedb7eb7fa331a2ccbecb9202d8abba64d37b3";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "trouble.nvim";
      rev = "85bedb7eb7fa331a2ccbecb9202d8abba64d37b3";
      fetchSubmodules = false;
      sha256 = "sha256-au9wp88a0CutEf2f8Bi0vFTUR0zvQKgFX1vMVg4myGI=";
    };
    date = "2025-02-12";
  };
  undotree = {
    pname = "undotree";
    version = "28f2f54a34baff90ea6f4a735ef1813ad875c743";
    src = fetchFromGitHub {
      owner = "mbbill";
      repo = "undotree";
      rev = "28f2f54a34baff90ea6f4a735ef1813ad875c743";
      fetchSubmodules = false;
      sha256 = "sha256-5WofUOTYE+Nmx3A5OoZBneJBHZ8bdGEYDZ6vTMx1OE0=";
    };
    date = "2025-07-13";
  };
  vim-fugitive = {
    pname = "vim-fugitive";
    version = "61b51c09b7c9ce04e821f6cf76ea4f6f903e3cf4";
    src = fetchFromGitHub {
      owner = "tpope";
      repo = "vim-fugitive";
      rev = "61b51c09b7c9ce04e821f6cf76ea4f6f903e3cf4";
      fetchSubmodules = false;
      sha256 = "sha256-u39oObHCXk8uew5HyVdV1Z69Viilv3B7x1SUJxYXYLo=";
    };
    date = "2025-07-15";
  };
  wakatime = {
    pname = "wakatime";
    version = "3cb40867cb5a3120f9bef76eff88edc7f1dc1a23";
    src = fetchFromGitHub {
      owner = "wakatime";
      repo = "vim-wakatime";
      rev = "3cb40867cb5a3120f9bef76eff88edc7f1dc1a23";
      fetchSubmodules = false;
      sha256 = "sha256-HxLmX+qws8A6+mFBGMdru2E3NXJ91P0HtDKMX8ryMzI=";
    };
    date = "2024-04-29";
  };
  yosu-nvim = {
    pname = "yosu-nvim";
    version = "b92a8d9e294025f1d249a24f0b2538c9a8a14007";
    src = fetchFromGitHub {
      owner = "comfysage";
      repo = "yosu.nvim";
      rev = "b92a8d9e294025f1d249a24f0b2538c9a8a14007";
      fetchSubmodules = false;
      sha256 = "sha256-ao7fnihe/aKyL3XAgqgIj5aVUhVS20JsYV56+QfNoJ4=";
    };
    date = "2025-05-09";
  };
  zk-nvim = {
    pname = "zk-nvim";
    version = "b18782530b23ad118d578c0fa0e4d0b8d386db4c";
    src = fetchFromGitHub {
      owner = "mickael-menu";
      repo = "zk-nvim";
      rev = "b18782530b23ad118d578c0fa0e4d0b8d386db4c";
      fetchSubmodules = false;
      sha256 = "sha256-g+DK9BTIGZxujrt0QEkcp0NGt8pPrYf4XGIX+IiA1PI=";
    };
    date = "2025-06-06";
  };
}
