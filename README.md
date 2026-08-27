# UX 플로우 생성기 — Figma/FigJam 플러그인

어떤 기획 md와 피그마 문서를 입력하든 동일한 규칙으로 UX 플로우를 FigJam에 그려주는 로컬 플러그인입니다.
프로젝트별 스펙 md·플로우 JSON은 이 저장소에 포함하지 않습니다 — 이 저장소는 **플러그인 로직만** 관리합니다.

## 동작 구조 (두 가지 경로)

**① 플러그인에서 직접 생성** — FigJam에서 플러그인 실행 → UX Flow 탭 → md 링크(GitHub blob/tree/raw)·피그마 링크 입력 → [⚡ 플로우 생성 → 그리기] → 서버가 gh CLI로 md 원문을 받고 Claude CLI로 flow JSON을 생성·검증·저장한 뒤 캔버스에 자동으로 그림. (요구: 로컬 서버 실행, `gh` 로그인, Claude Code CLI 로그인)

**② Claude Code 스킬 경로**

```
기획 md + 피그마 링크
   → Claude `uxflow-generator` 스킬이 flow JSON 생성·검증
   → 로컬 서버(localhost:3765)에 전송 (ux-flows/에 저장, git 제외)
   → FigJam에서 플러그인 실행 → UX Flow 탭 → 플로우 클릭 → 캔버스에 그려짐
```

## 새 컴퓨터에서 세팅

1. 이 저장소를 클론합니다.
2. 스킬 저장소를 클론하고 Claude Code 스킬로 연결합니다:

```bash
git clone https://github.com/hy0909/skills.git ~/Downloads/skills && ln -sfn ~/Downloads/skills/uxflow-generator ~/.claude/skills/uxflow-generator
```

3. 플러그인 폴더에서 서버를 실행합니다:

```bash
./start-server.sh
```

4. Figma Desktop에서 `Plugins > Development > Import plugin from manifest...` → 이 폴더의 `manifest.json` 선택.
5. Claude Code에 기획 md(또는 GitHub 링크)와 피그마 링크를 주고 UX 플로우 생성을 요청 → FigJam 보드에서 `UX 플로우 생성기` 플러그인 실행 → `UX Flow` 탭에서 플로우 클릭.

## 그리기 규칙 (플러그인이 보장)

- 도형 규칙 범례 자동 표시: 타원=시작·종료 / 사각형=화면 / 둥근사각형=액션 / 마름모=분기 / 평행사변형=API
- 색: 회색=정상 경로, 빨강=에러 경로, 주황=예외 경로, 파랑=API
- 필수/선택 입력: 라벨의 `*` → `(필수항목)`(빨간색), `(선택)` → `(선택항목)`으로 변환 표기
- 모든 테두리 1px, 모든 텍스트 Inter
- 참고 링크는 우측 상단에 라벨만 하이퍼링크로 표기: 📄 스펙 md(docLinks), 🔗 피그마(figmaLinks)
- 커넥터는 그리드 방향 기반 부착(오른쪽 진행 RIGHT→LEFT, 루프백 LEFT→RIGHT, 같은 열 BOTTOM/TOP) — 다른 노드 관통 방지

## 기타 기능

- 화면 정의서·예외 케이스·화면 구조/사이즈·컴포넌트 MD 명세 생성 (`기능명세-생성-로직-법칙.md` 참조)
