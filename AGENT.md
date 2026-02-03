# AGENT.md

이 문서는 Claude AI 및 기타 AI 에이전트가 이 Neovim 설정 레포지토리를 이해하고 작업할 수 있도록 작성된 분석 보고서입니다.

## 프로젝트 개요

이 프로젝트는 **Neovim 0.9+**를 위한 현대적이고 모듈형으로 구성된 플러그인 설정입니다.

- **플러그인 매니저**: lazy.nvim
- **언어**: Lua
- **현재 컬러스킴**: oxocarbon (init.lua:20)
- **리더 키**: Space (`<leader> = " "`)

## 아키텍처

### 디렉토리 구조

```
nvim/
├── init.lua                    # 진입점: lazy.nvim 부트스트랩 및 설정 로드
├── CLAUDE.md                   # Claude AI용 가이드 (레퍼런스)
├── README.md                   # 프로젝트 README
├── ftdetect/
│   └── astro.lua              # Astro 파일 타입 감지
├── lua/
│   ├── config/                # Vim 옵션 및 기본 설정
│   │   ├── init.lua          # 설정 모듈 로드 (options, autocmds, keymaps)
│   │   ├── options.lua       # Vim 옵션 (indentation, encoding, UI)
│   │   ├── keymaps.lua       # 전역 키바인딩
│   │   └── autocmds.lua       # 자동 명령 (윈도우 리사이즈, 포맷팅)
│   ├── config-vscode/         # VSCode 호환용 설정
│   │   ├── init.lua
│   │   ├── options.lua
│   │   └── keymaps.lua
│   └── plugins/               # 플러그인 설정 (lazy.nvim이 자동 로드)
│       ├── lsp.lua           # LSP 서버 및 폼터 (Mason, nvim-lspconfig)
│       ├── ui.lua            # UI 컴포넌트 (lualine, bufferline, indent guides)
│       ├── editor.lua         # 편집 기능 (neo-tree, fzf-lua, flash, zen-mode)
│       ├── treesitter.lua     # Treesitter 구성 (중복 - coding/treesitter.lua가 메인)
│       ├── colorscheme.lua    # 컬러스킴 (oxocarbon, tokyonight, gruvbox)
│       ├── termianl.lua       # 터미널 통합 (toggleterm) - 오타 유의
│       └── coding/            # 코딩 관련 플러그인 하위 디렉토리
│           ├── init.lua       # 모든 코딩 플러그인 로드
│           ├── nvim_cmp.lua   # 완성 엔진
│           ├── nvim_autopairs.lua # 자동 괄호 닫기
│           ├── autoclose.lua  # 자동 태그 닫기
│           ├── treesitter.lua # Treesitter (메인 설정)
│           ├── trouble.lua    # 진단 뷰어
│           ├── todo_comments.lua # TODO 주석 강조
│           ├── lazygit.lua    # Git 통합
│           ├── copilot.lua    # GitHub Copilot
│           ├── claude.lua     # Claude Code 통합
│           └── tailwind_fold.lua # Tailwind 접기
```

### 설계 패턴

1. **모듈형 플러그인 구성**: 플러그인을 기능별로 분리 (UI, editor, LSP, coding)
2. **자동 로딩**: lazy.nvim이 `lua/plugins/` 및 하위 디렉토리의 모든 `.lua` 파일을 자동으로 로드
3. **Lazy Loading**: 대부분의 플러그인은 `event`, `cmd`, `keys`, `ft` 트리거로 lazy loading
4. **중앙 집중형 설정**: `lua/config/`에 기본 옵션과 키바인딩을 중앙에서 관리

## 주요 구성 요소

### 1. Vim 옵션 (lua/config/options.lua)

**주요 설정**:
- 인덴트: `shiftwidth=2`, `tabstop=2`, `expandtab=true`
- 행 번호: `number=true`, `relativenumber=true`
- 인코딩: UTF-8 + cp949 (한국어 지원)
- 클립보드: `unnamedplus` (시스템 클립보드 사용)
- 마우스: `a` (모든 모드에서 마우스 지원)
- 커서라인: `false` (비활성화)
- UI: `termguicolors=true`, `fillchars={eob=" "}` (빈 라인 문자 제거)
- 검색: `hlsearch=true`, `smartcase=true`

### 2. 키바인딩 (lua/config/keymaps.lua)

**윈도우 관리**:
- `<C-h/j/k/l>`: 윈도우 간 이동
- `<leader>h/j/k/l`: 윈도우 분할 (neo-tree 동기화 포함)
- `<C-q>`: 버퍼 닫기 (윈도우는 유지)
- `<C-w>`: 버퍼 닫기 (윈도우 닫지 않음)
- `<S-h/l>`: 버퍼 간 탐색

**파일 탐색**:
- `<C-p>`: fzf-lua 파일 퍼지 파인더
- `<leader>nt`: Neo-Tree 파일 탐색기 토글

**편집 기능**:
- `j/k`와 `gj/gk` 교체 (줄 래핑 시 올바른 이동)
- `<S-p>`: 레지스터 유지하며 붙여넣기
- `<Esc>`: 검색 하이라이트 제거
- `<C-s>`: 파일 저장
- `s`: Flash 점프
- `gt`: BufferLine에서 버퍼 선택

**터미널**:
- `<C-\>`: ToggleTerm 터미널 토글
- `<Esc>`: 터미널에서 노말 모드로 전환
- `<leader>gm`: Gemini CLI 터미널 토글

**기타**:
- `<leader>z`: Zen-Mode 토글
- `<leader>gg`: LazyGit 열기

### 3. 자동 명령 (lua/config/autocmds.lua)

- **윈도우 리사이즈**: `VimResized` 이벤트 시 자동 윈도우 크기 조정
- **마크다운**: shiftwidth=2 설정
- **Python 저장 시**: yapf 자동 포맷팅

### 4. LSP 구성 (lua/plugins/lsp.lua)

**설치된 LSP 서버**:
- **Python**: pyright
- **TypeScript/JavaScript**: ts_ls + eslint (저장 시 자동 고정)
- **웹 개발**: html, cssls, cssmodules_ls, tailwindcss, emmet_ls
- **Astro**: astro
- **Lua**: lua_ls

**폼터**:
- **Prettier**: 다양한 파일 타입 지원 (css, graphql, html, js, json, markdown, scss, ts, yaml, astro, lua)
- **ESLint**: 저장 시 자동 고정 활성화
- **YAPF**: Python 파일 저장 시 자동 포맷팅 (autocmds.lua:21-25)

**LSP 키바인딩** (LSP 연결 시):
- `gd`: 정의로 이동
- `gD`: 선언으로 이동
- `gi`: 구현으로 이동
- `gr`: 참조로 이동
- `K`: 호버 문서
- `<space>rn`: 심볼 이름 변경
- `<space>ca`: 코드 액션
- `<space>wa/wr/wl`: 워크스페이스 폴더 관리
- `<leader>cr`: LSP 재시작

**진단 (Trouble)**:
- `<leader>xx`: 진단 토글
- `<leader>xX`: 버퍼 진단 토글
- `<leader>cs`: 심볼 토글
- `<leader>cl`: LSP 정의/참조 토글

### 5. UI 플러그인 (lua/plugins/ui.lua)

- **lualine**: 스테이터스라인 (파일명, 진행률, 시간, 확장: neo-tree, lazy)
- **bufferline**: 버퍼 탭 (번호 표시, 진단 아이콘, slant 스타일)
- **nvim-notify**: 향상된 알림 (3초 타임아웃, 최대 75% 화면 크기)
- **dressing.nvim**: 향상된 vim.ui (select, input)
- **indent-blankline.nvim**: 들여쓰기 가이드 (│ 문자)
- **mini.indentscope**: 활성 들여쓰기 가이드 (│ 문자)

### 6. 편집 기능 (lua/plugins/editor.lua)

- **Neo-Tree**: 파일 탐색기 (`<leader>nt` 토글)
- **fzf-lua**: 퍼지 파인더 (`<C-p>` 파일 검색, 70% 화면 크기)
- **flash.nvim**: 향상된 검색/점프 (`s` 점프, `S` Treesitter, `r` 원격 Flash)
- **zen-mode.nvim**: 집중 모드 (`<leader>z`, width=130, twilight 활성화, Alacritty 폰트 크기 조절)
- **markdown-preview.nvim**: 마크다운 미리보기
- **auto-session**: 자동 세션 관리 (홈/프로젝트/다운로드 디렉토리 제외)

### 7. 코딩 플러그인 (lua/plugins/coding/)

#### nvim-cmp (nvim_cmp.lua)
**완성 엔진**:
- 소스: nvim_lsp (최대 10개), vsnip (최대 5개), path (최대 5개), buffer
- 키바인딩:
  - `<C-n/p>`: 다음/이전 항목 선택
  - `<C-b/f>`: 문서 스크롤
  - `<C-Space>`: 완성 트리거
  - `<C-e>`: 중단
  - `<CR>`: 확인
  - `<S-CR>`: 교체 후 확인
  - `<C-CR>`: 중단 후 폴백
- vsnip 스니펫 사용

#### Treesitter (coding/treesitter.lua - 메인 설정)
**설치된 언어**:
c, cpp, go, lua, python, rust, javascript, jsdoc, typescript, tsx, astro, css, vimdoc, vim, bash, http, json, html

**기능**:
- 하이라이트: 활성화
- 자동 태그: 활성화
- 증분 선택:
  - `<C-space>`: 선택 시작/확장
  - `<C-s>`: 스코프 확장
  - `<M-space>`: 축소
- 텍스트 오브젝트:
  - `aa/ia`: 파라미터 outer/inner
  - `af/if`: 함수 outer/inner
  - `ac/ic`: 클래스 outer/inner
- 이동:
  - `]m/]/]/[M/[]`: 함수/클래스로 이동
- 교환: `<leader>a/A`: 파라미터 교환

#### Git
**lazygit**: (`<leader>gg` LazyGit 열기)
- 플로팅 윈도우 설정
- tokyonight 테마 색상 사용

#### 기타 코딩 도구
- **nvim-autopairs**: 자동 괄호/따옴표 닫기
- **autoclose**: 자동 HTML/XML 태그 닫기
- **todo-comments.nvim**: TODO/FIXME/HACK 주석 강조
- **trouble.nvim**: 진단 및 문제 뷰어 (키바인딩: LSP 구성 참조)
- **GitHub Copilot**: AI 코드 완성 (copilot.lua)
- **Claude Code**: Claude AI 통합 (claude.lua)

### 8. 컬러스킴 (lua/plugins/colorscheme.lua)

**설치된 스킴**:
- **oxocarbon** (현재 활성화, init.lua:20)
- **tokyonight** (style=moon, transparent=false)
- **gruvbox** (terminal_colors=true, bold=true, italic 활성화, inverse=true)
- **monoglow** (lazy=false, priority=1000)

### 9. 터미널 (lua/plugins/termianl.lua)
**ToggleTerm**:
- 토글: `<C-\>`
- 방향: horizontal (기본), vertical (Gemini CLI)
- 크기: horizontal=20행, vertical=30% 열
- 노말 모드로 전환: `<Esc>`

### 10. VSCode 호환 (lua/config-vscode/)
- VSCode에서 Neovim 사용 시 별도 설정 로드
- 기본 설정과 유사한 구조

## 워크플로우

### 설정 변경 테스트
1. 파일 소싱: `:source %` 또는 `:so %`
2. 플러그인 변경: `:Lazy reload {plugin-name}`
3. 전체 초기화: Neovim 재시작

### 새 플러그인 추가
1. `lua/plugins/` 또는 `lua/plugins/coding/`에 새 `.lua` 파일 생성
2. 플러그인 spec 테이블 반환
3. 다음 재시작 시 lazy.nvim이 자동 로드
4. 설치: `:Lazy sync`

### LSP 서버 관리
- 서버 설치: `:Mason` (UI 열기) 또는 `lsp.lua`에 설정
- LSP 재시작: `<leader>cr` 또는 `:LspRestart`

### 플러그인 업데이트
- `:Lazy update` - 모든 플러그인 업데이트
- `:Lazy sync` - 설치/업데이트/정리

## 특별 고려사항

### 인코딩
한국어 cp949 인코딩 지원 (options.lua:19):
```lua
vim.opt.fileencodings = { 'utf-8', 'cp949', 'ucs-bom' }
```

### 자동 포맷팅
- **Python**: 저장 시 yapf (autocmds.lua:21-25)
- **JavaScript/TypeScript**: 저장 시 eslint 자동 고정
- **기타**: Prettier (다양한 파일 타입)

### 터미널 통합
- **일반 터미널**: ToggleTerm (`<C-\>`)
- **Gemini CLI**: 사용자 정의 터미널 (`<leader>gm`)

### 버퍼 관리
버퍼 닫기 명령 (`<C-q>`, `<C-w>`)은 복잡한 로직 사용:
- `:bp|sp|bn|bd` 패턴으로 마지막 버퍼 닫을 때 윈도우 닫기 방지
- 분할 명령 (`<leader>h/j/k/l`) 시 neo-tree와 동기화

### VSCode 모드
`init.lua:1-3`에서 감지:
```lua
if vim.g.vscode then
  require "config-vscode"
else
  -- 일반 Neovim 설정
end
```

## 알려진 문제 및 주의사항

1. **Treesitter 중복**: `lua/plugins/treesitter.lua`와 `lua/plugins/coding/treesitter.lua`가 거의 동일함. 후자가 메인으로 사용됨
2. **파일명 오타**: `lua/plugins/termianl.lua` (terminal → termianl)
3. **Treesitter 중복**: `lua/plugins/treesitter.lua`와 `lua/plugins/coding/treesitter.lua` 중복
4. **Lazygit 색상**: tokyonight 테마에 종속됨 (lazygit.lua:21)

## 사용자 정의 가이드

### 스타일 및 컨벤션
- Lua로 작성
- 기존 플러그인 스타일 따르기
- 같은 라이브러리 사용 (예: 테마 설정 시 이미 설치된 테마 확인)
- 보안 모범 사례 따르기 (노출/로깅 방지, 시크릿/키 커밋 방지)

### 테스트
- 구문 확인: Neovim에서 파일 열기
- 린트/타입 체크: 없음 (사용자에게 문의 필요)

### Git 커밋
사용자가 명시적으로 요청 시에만 생성됨. 요청 없이 생성하지 않음.

## 플러그인 요약

| 카테고리 | 플러그인 | 용도 | 키바인딩 |
|---------|---------|------|---------|
| **플러그인 매니저** | lazy.nvim | 플러그인 관리 | - |
| **LSP** | nvim-lspconfig | LSP 클라이언트 | gd, gD, gi, gr, K, <space>rn, <space>ca, <leader>cr |
| | Mason | LSP 서버 관리자 | :Mason |
| | prettier.nvim | 코드 포맷터 | - |
| | eslint.nvim | ESLint 통합 | - |
| **UI** | lualine.nvim | 스테이터스라인 | - |
| | bufferline.nvim | 버퍼 탭 | gt |
| | nvim-notify | 알림 | <leader>un |
| | dressing.nvim | 향상된 vim.ui | - |
| | indent-blankline.nvim | 들여쓰기 가이드 | - |
| | mini.indentscope | 활성 들여쓰기 가이드 | - |
| **편집기** | neo-tree.nvim | 파일 탐색기 | <leader>nt, \ |
| | fzf-lua | 퍼지 파인더 | <C-p> |
| | flash.nvim | 검색/점프 | s, S, r, R |
| | zen-mode.nvim | 집중 모드 | <leader>z |
| | markdown-preview.nvim | 마크다운 미리보기 | - |
| | auto-session | 세션 관리 | - |
| **코딩** | nvim-cmp | 완성 엔진 | <C-n/p>, <C-b/f>, <C-Space>, <CR> |
| | nvim-treesitter | 구문 하이라이팅 | <C-space>, <M-space>, aa/af/ac 등 |
| | nvim-autopairs | 자동 괄호 닫기 | - |
| | autoclose.nvim | 자동 태그 닫기 | - |
| | trouble.nvim | 진단 뷰어 | <leader>xx, <leader>xX, <leader>cs, <leader>cl |
| | todo-comments.nvim | TODO 주석 강조 | - |
| | lazygit.nvim | Git UI | <leader>gg |
| | copilot.vim | AI 코드 완성 | - |
| | claude-code.nvim | Claude AI 통합 | - |
| | tailwind_fold.nvim | Tailwind 접기 | - |
| **터미널** | toggleterm.nvim | 터미널 토글 | <C-\> |
| **컬러스킴** | oxocarbon.nvim | 현재 테마 | - |
| | tokyonight.nvim | 대체 테마 | - |
| | gruvbox.nvim | 대체 테마 | - |
| | monoglow.nvim | 대체 테마 | - |

---

**문서 버전**: 1.0
**마지막 업데이트**: 2026-01-22
**Neovim 버전**: 0.9+
