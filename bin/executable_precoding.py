#!/usr/bin/env python3
"""
precoding.py - Generate a "before writing code" playbook and design documents.

Commands:
    playbook      Generate the playbook (decision tree + step details) as markdown.
    new-design    Generate a design document skeleton, sized to the change's risk.

Both commands accept --lang en|fr (default: en).
Run `python precoding.py -h` or `python precoding.py <command> -h` for details.

Examples:
    python precoding.py playbook
    python precoding.py playbook --lang fr
    python precoding.py new-design "Add retry policy to the HTTP client" --size medium
    python precoding.py new-design "Politique de relance du client HTTP" \\
        --size large --lang fr --author Simon --acceptance-tests --modifies-existing

Standard library only.
"""

from __future__ import annotations

import argparse
import re
import sys
import unicodedata
from dataclasses import dataclass
from datetime import date
from pathlib import Path

LANGS = ("en", "fr")

# ---------------------------------------------------------------------------
# Playbook content
# ---------------------------------------------------------------------------

PLAYBOOK = {
    "en": """\
# Pre-coding Playbook

*Generated on {today}. Regenerate with `python precoding.py playbook --lang en`.*

Four phases: **clarify → explore → design → validate**. Each one produces a small
artifact someone else can review. Scale the effort to the risk of the change.

## Decision tree

Go through the questions in order. When an answer sends you to a step, do it, then continue.

1. **Can you write concrete examples (input → expected behavior)?**
   - No → do **Step 1: Clarify**, then answer this question again.
   - Yes → continue.
2. **Do you know the exact code paths involved?**
   - No → do **Step 2: Explore**, then answer this question again.
   - Yes → continue.
3. **Does a first naive attempt break many things?**
   - Yes → apply the **Mikado Method** (Step 2), then continue.
   - No → continue.
4. **Does the change modify existing behavior?**
   - Yes → write **characterization tests** first, as their own PR (Step 3).
   - No → continue.
5. **Is the behavior hard to verify with unit tests alone** (end-to-end flows, performance, user experience, integrations)?
   - Yes → define **acceptance tests and success criteria** (reuse your examples from Step 1).
   - No → continue.
6. **What is the risk / size of the change?** (see the table below)
   - Small → short design note in the PR description.
   - Medium → design doc, async review with the lead.
   - Large → full design doc + design review meeting.
7. **Plan the PR breakdown** (Step 5), then start coding.

## Sizing the design artifact

| Size | Typical signals | Design artifact |
|------|-----------------|-----------------|
| **Small** | One module, no change to existing flows, easy to revert | Design note in the PR description |
| **Medium** | Several modules, changes existing behavior, needs a feature flag | Design doc (1–2 pages), async review |
| **Large** | Core business logic, new dependencies, data or API contract changes, hard to revert | Full design doc + review meeting |

When in doubt, size up. A design doc that takes an hour is cheap compared to a rewrite.

## Step 1: Clarify the problem

- [ ] Write 3–10 **concrete examples**: *given this input and this state, the system should do X*.
- [ ] Include at least one edge case and one failure case.
- [ ] List **non-goals** explicitly (what this change will *not* do).
- [ ] Define **done**: which tests, which acceptance criteria, which metrics or observable outcomes.
- [ ] Confirm the examples with whoever requested the feature.

> These examples are the seed of your acceptance tests. Keep them.

## Step 2: Explore the codebase

- [ ] **Trace a similar existing feature end to end** (debugger breakpoints or temporary logs), from entry point to output.
- [ ] Note the actual architecture: which modules, which data structures, which side effects.
- [ ] Run `git log -p --follow <file>` and `git blame` on the files you will touch. Read the related PRs.
- [ ] **Timeboxed spike** (e.g. half a day): hack the feature on a throwaway branch to find the hard parts. Write down what you learned, then delete the branch.
- [ ] Identify **seams**: places where you can add behavior or tests without editing much code (interfaces, dependency injection points, config, hooks).

### If the change is tangled: the Mikado Method

1. Write the goal at the top of a list.
2. Try the change naively.
3. If things break, note each prerequisite change as a child of the goal, then **revert**.
4. Repeat on each prerequisite until you reach changes that work on their own.
5. Implement from the leaves up. Each leaf is usually one small, safe PR.

## Step 3: Protect existing behavior

- [ ] For every function you will modify, write **characterization tests** that pin its *current* output (not the expected one).
- [ ] Use snapshot (golden master) testing for complex outputs such as generated files, API responses, or rendered views.
- [ ] Mock external dependencies (databases, network calls, third-party services, clock, randomness) so the tests are deterministic.
- [ ] Mark surprising behavior with a comment (`# possible bug?`) instead of fixing it now.
- [ ] Ship these tests as their own PR, before any behavior change.

## Step 4: Design

- [ ] Size the change (see the table above) and pick the matching artifact.
- [ ] Generate the skeleton: `python precoding.py new-design "<feature>" --size <size>`.
- [ ] Always consider at least **one alternative** and explain why you rejected it.
- [ ] Add a data or control flow description. It is the part a reviewer unfamiliar with the codebase will use the most.

## Step 5: Validate before coding

- [ ] Review the design with your lead. Focus the discussion on approach, risks, and testing, not on code.
- [ ] Plan the **PR breakdown**: small (≈200–400 lines of diff), each reviewable on its own, refactors separate from behavior changes.
- [ ] Decide on the feature flag and rollback plan.
""",
    "fr": """\
# Guide pré-codage

*Généré le {today}. Pour régénérer : `python precoding.py playbook --lang fr`.*

Quatre phases : **clarifier → explorer → concevoir → valider**. Chacune produit un
petit livrable que quelqu'un d'autre peut réviser. Adaptez l'effort au risque du changement.

## Arbre de décision

Répondez aux questions dans l'ordre. Quand une réponse vous renvoie à une étape, faites-la, puis continuez.

1. **Pouvez-vous écrire des exemples concrets (entrée → comportement attendu)?**
   - Non → faites l'**étape 1 : Clarifier**, puis revenez à cette question.
   - Oui → continuez.
2. **Connaissez-vous les chemins de code exacts concernés?**
   - Non → faites l'**étape 2 : Explorer**, puis revenez à cette question.
   - Oui → continuez.
3. **Une première tentative naïve brise-t-elle beaucoup de choses?**
   - Oui → appliquez la **méthode Mikado** (étape 2), puis continuez.
   - Non → continuez.
4. **Le changement modifie-t-il un comportement existant?**
   - Oui → écrivez d'abord des **tests de caractérisation**, dans une PR distincte (étape 3).
   - Non → continuez.
5. **Le comportement est-il difficile à vérifier avec des tests unitaires seulement** (flux de bout en bout, performance, expérience utilisateur, intégrations)?
   - Oui → définissez des **tests d'acceptation et des critères de réussite** (réutilisez vos exemples de l'étape 1).
   - Non → continuez.
6. **Quel est le risque / la taille du changement?** (voir le tableau ci-dessous)
   - Petit → courte note de conception dans la description de la PR.
   - Moyen → document de conception, révision asynchrone avec le chef d'équipe.
   - Grand → document de conception complet + rencontre de révision.
7. **Planifiez le découpage en PR** (étape 5), puis commencez à coder.

## Choisir le livrable de conception

| Taille | Signaux typiques | Livrable |
|--------|------------------|----------|
| **Petit** | Un seul module, aucun changement aux flux existants, facile à annuler | Note dans la description de la PR |
| **Moyen** | Plusieurs modules, modifie un comportement existant, nécessite un feature flag | Document de conception (1–2 pages), révision asynchrone |
| **Grand** | Logique d'affaires centrale, nouvelles dépendances, changements de contrat de données ou d'API, difficile à annuler | Document complet + rencontre de révision |

En cas de doute, choisissez la taille supérieure. Un document d'une heure coûte peu comparé à une réécriture.

## Étape 1 : Clarifier le problème

- [ ] Écrivez 3 à 10 **exemples concrets** : *avec cette entrée et cet état, le système devrait faire X*.
- [ ] Incluez au moins un cas limite et un cas d'échec.
- [ ] Listez explicitement les **non-objectifs** (ce que ce changement ne fera *pas*).
- [ ] Définissez ce que veut dire **terminé** : quels tests, quels critères d'acceptation, quelles métriques ou résultats observables.
- [ ] Faites valider les exemples par la personne qui a demandé la fonctionnalité.

> Ces exemples sont le point de départ de vos tests d'acceptation. Conservez-les.

## Étape 2 : Explorer le code

- [ ] **Tracez une fonctionnalité existante similaire de bout en bout** (points d'arrêt du débogueur ou logs temporaires), du point d'entrée jusqu'à la sortie.
- [ ] Notez l'architecture réelle : quels modules, quelles structures de données, quels effets de bord.
- [ ] Lancez `git log -p --follow <fichier>` et `git blame` sur les fichiers que vous allez toucher. Lisez les PR associées.
- [ ] **Spike limité dans le temps** (p. ex. une demi-journée) : implémentez la fonctionnalité rapidement sur une branche jetable pour repérer les difficultés. Notez ce que vous avez appris, puis supprimez la branche.
- [ ] Repérez les **points d'insertion** (*seams*) : les endroits où vous pouvez ajouter du comportement ou des tests sans modifier beaucoup de code (interfaces, injection de dépendances, configuration, hooks).

### Si le changement est enchevêtré : la méthode Mikado

1. Écrivez l'objectif en haut d'une liste.
2. Tentez le changement naïvement.
3. Si des choses brisent, notez chaque changement préalable comme enfant de l'objectif, puis **annulez**.
4. Répétez sur chaque prérequis jusqu'à obtenir des changements qui fonctionnent seuls.
5. Implémentez à partir des feuilles. Chaque feuille correspond généralement à une petite PR sans risque.

## Étape 3 : Protéger le comportement existant

- [ ] Pour chaque fonction que vous allez modifier, écrivez des **tests de caractérisation** qui figent son résultat *actuel* (et non le résultat attendu).
- [ ] Utilisez des tests par instantané (golden master) pour les sorties complexes comme des fichiers générés, des réponses d'API ou des vues affichées.
- [ ] Simulez (mock) les dépendances externes (bases de données, appels réseau, services tiers, horloge, aléatoire) pour que les tests soient déterministes.
- [ ] Signalez les comportements surprenants par un commentaire (`# bogue possible?`) au lieu de les corriger tout de suite.
- [ ] Livrez ces tests dans leur propre PR, avant tout changement de comportement.

## Étape 4 : Concevoir

- [ ] Évaluez la taille du changement (voir le tableau ci-dessus) et choisissez le livrable correspondant.
- [ ] Générez le squelette : `python precoding.py new-design "<fonctionnalité>" --size <taille> --lang fr`.
- [ ] Considérez toujours au moins **une alternative** et expliquez pourquoi vous l'avez écartée.
- [ ] Ajoutez une description du flux de données ou de contrôle. C'est la partie la plus utile pour un réviseur qui connaît peu le code.

## Étape 5 : Valider avant de coder

- [ ] Révisez la conception avec votre chef d'équipe. Concentrez la discussion sur l'approche, les risques et les tests, pas sur le code.
- [ ] Planifiez le **découpage en PR** : petites (≈200–400 lignes de diff), révisables individuellement, avec le refactoring séparé des changements de comportement.
- [ ] Décidez du feature flag et du plan de retour arrière.
""",
}


def render_playbook(lang: str) -> str:
    return PLAYBOOK[lang].replace("{today}", date.today().isoformat())


# ---------------------------------------------------------------------------
# Design document content
# ---------------------------------------------------------------------------

DESIGN = {
    "en": {
        "title": "Design",
        "meta": ["Author", "Date", "Size", "Status", "Reviewers"],
        "status": "Draft",
        "sizes": {"small": "Small", "medium": "Medium", "large": "Large"},
        "context": ("Context and problem", """
<!-- Why are we doing this? What happens today, and what is wrong with it?
     2–5 sentences. Link the ticket. -->
"""),
        "examples": ("Examples of expected behavior", """
<!-- Concrete cases. These become acceptance tests. -->

| # | Input / state | Expected behavior | Notes |
|---|---------------|-------------------|-------|
| 1 | | | Nominal case |
| 2 | | | Edge case |
| 3 | | | Failure case |
"""),
        "goals": ("Goals and non-goals", """
**Goals**

-

**Non-goals**

-
"""),
        "approach": ("Proposed approach", """
<!-- Describe the approach in plain language first, then the details.
     Write for a reader who does not know this language or codebase. -->

### Flow

1. Entry point:
2. New component:
3. Existing components called:
4. Output:

### Components impacted

| File / module | Change | Notes |
|---------------|--------|-------|
| | New / Modified / Removed | |
"""),
        "alternatives": ("Alternatives considered", """
| Alternative | Pros | Cons | Why rejected |
|-------------|------|------|--------------|
| | | | |
"""),
        "existing": ("Existing behavior and characterization tests", """
<!-- Which existing behavior are we modifying, and how do we pin it first? -->

| Function / module | Current behavior (pinned by) | Surprising behavior found |
|-------------------|------------------------------|---------------------------|
| | `tests/...` | |
"""),
        "testing": ("Testing plan", """
- **Unit tests:**
- **Characterization tests** (existing behavior):
- **Integration tests:**
"""),
        "acceptance": """- **Acceptance tests:**
  - Scenarios covered (reuse the examples above):
  - Success criteria (e.g. response time, error rate, user-visible outcome):
  - Environment (staging, production-like data, manual QA):
""",
        "risks": ("Risks and rollback", """
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| | Low / Med / High | Low / Med / High | |

- **Feature flag:**
- **Rollback plan:**
"""),
        "observability": ("Observability", """
<!-- How will we know it works in production? Logs, traces, metrics, alerts. -->

-
"""),
        "mikado": ("Mikado graph / prerequisites", """
<!-- Prerequisite changes discovered during the spike. Implement from the leaves up. -->

- Goal: {title}
  - Prerequisite A
    - Prerequisite A.1
  - Prerequisite B
"""),
        "prs": ("PR breakdown", """
<!-- Small PRs (≈200–400 lines of diff). Refactoring separate from behavior changes. -->

| # | PR | Type | Depends on |
|---|----|------|------------|
| 1 | Characterization tests for ... | Tests only | – |
| 2 | | Refactor | 1 |
| 3 | | Feature (behind flag) | 2 |
"""),
        "questions": ("Open questions", """
-
"""),
    },
    "fr": {
        "title": "Conception",
        "meta": ["Auteur", "Date", "Taille", "Statut", "Réviseurs"],
        "status": "Brouillon",
        "sizes": {"small": "Petit", "medium": "Moyen", "large": "Grand"},
        "context": ("Contexte et problème", """
<!-- Pourquoi fait-on ce changement? Que se passe-t-il aujourd'hui, et qu'est-ce qui ne va pas?
     2 à 5 phrases. Ajoutez le lien vers le billet. -->
"""),
        "examples": ("Exemples du comportement attendu", """
<!-- Cas concrets. Ils deviennent des tests d'acceptation. -->

| # | Entrée / état | Comportement attendu | Notes |
|---|---------------|----------------------|-------|
| 1 | | | Cas nominal |
| 2 | | | Cas limite |
| 3 | | | Cas d'échec |
"""),
        "goals": ("Objectifs et non-objectifs", """
**Objectifs**

-

**Non-objectifs**

-
"""),
        "approach": ("Approche proposée", """
<!-- Décrivez d'abord l'approche en langage simple, puis les détails.
     Écrivez pour un lecteur qui ne connaît ni ce langage ni ce code. -->

### Flux

1. Point d'entrée :
2. Nouveau composant :
3. Composants existants appelés :
4. Sortie :

### Composants touchés

| Fichier / module | Changement | Notes |
|------------------|------------|-------|
| | Nouveau / Modifié / Supprimé | |
"""),
        "alternatives": ("Alternatives considérées", """
| Alternative | Avantages | Inconvénients | Raison du rejet |
|-------------|-----------|---------------|-----------------|
| | | | |
"""),
        "existing": ("Comportement existant et tests de caractérisation", """
<!-- Quel comportement existant modifie-t-on, et comment le fige-t-on d'abord? -->

| Fonction / module | Comportement actuel (figé par) | Comportement surprenant relevé |
|-------------------|--------------------------------|--------------------------------|
| | `tests/...` | |
"""),
        "testing": ("Plan de tests", """
- **Tests unitaires :**
- **Tests de caractérisation** (comportement existant) :
- **Tests d'intégration :**
"""),
        "acceptance": """- **Tests d'acceptation :**
  - Scénarios couverts (réutiliser les exemples ci-dessus) :
  - Critères de réussite (p. ex. temps de réponse, taux d'erreur, résultat visible pour l'utilisateur) :
  - Environnement (préproduction, données réalistes, AQ manuelle) :
""",
        "risks": ("Risques et retour arrière", """
| Risque | Probabilité | Impact | Atténuation |
|--------|-------------|--------|-------------|
| | Faible / Moyenne / Élevée | Faible / Moyen / Élevé | |

- **Feature flag :**
- **Plan de retour arrière :**
"""),
        "observability": ("Observabilité", """
<!-- Comment saura-t-on que ça fonctionne en production? Logs, traces, métriques, alertes. -->

-
"""),
        "mikado": ("Graphe Mikado / prérequis", """
<!-- Changements préalables découverts pendant le spike. Implémenter à partir des feuilles. -->

- Objectif : {title}
  - Prérequis A
    - Prérequis A.1
  - Prérequis B
"""),
        "prs": ("Découpage en PR", """
<!-- Petites PR (≈200–400 lignes de diff). Refactoring séparé des changements de comportement. -->

| # | PR | Type | Dépend de |
|---|----|------|-----------|
| 1 | Tests de caractérisation pour ... | Tests seulement | – |
| 2 | | Refactoring | 1 |
| 3 | | Fonctionnalité (derrière un flag) | 2 |
"""),
        "questions": ("Questions ouvertes", """
-
"""),
    },
}


@dataclass
class DesignOptions:
    title: str
    size: str  # "small" | "medium" | "large"
    author: str
    acceptance_tests: bool
    modifies_existing: bool
    lang: str


def _section(title: str, body: str) -> str:
    return f"## {title}\n\n{body.strip()}\n"


def render_design_doc(opts: DesignOptions) -> str:
    t = DESIGN[opts.lang]
    todo = "_TODO_"
    meta_values = [
        opts.author or todo,
        date.today().isoformat(),
        t["sizes"][opts.size],
        t["status"],
        todo,
    ]
    rows = "\n".join(f"| **{k}** | {v} |" for k, v in zip(t["meta"], meta_values))
    parts = [f"# {t['title']} : {opts.title}\n\n| | |\n|---|---|\n{rows}\n"
             if opts.lang == "fr" else
             f"# {t['title']}: {opts.title}\n\n| | |\n|---|---|\n{rows}\n"]

    def add(key: str) -> None:
        title, body = t[key]
        parts.append(_section(title, body.replace("{title}", opts.title)))

    add("context")
    add("examples")
    add("goals")
    add("approach")
    if opts.size in ("medium", "large"):
        add("alternatives")
    if opts.modifies_existing:
        add("existing")

    testing_title, testing_body = t["testing"]
    if opts.acceptance_tests:
        testing_body = testing_body.rstrip() + "\n" + t["acceptance"]
    parts.append(_section(testing_title, testing_body))

    if opts.size in ("medium", "large"):
        add("risks")
    if opts.size == "large":
        add("observability")
        add("mikado")
    add("prs")
    add("questions")

    return "\n".join(parts)


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def slugify(text: str) -> str:
    text = unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode()
    text = re.sub(r"[^a-z0-9]+", "-", text.lower().strip())
    return text.strip("-") or "design"


def write_file(path: Path, content: str, force: bool) -> None:
    if path.exists() and not force:
        sys.exit(f"error: {path} already exists (use --force to overwrite)")
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")
    print(f"wrote {path}")


def cmd_playbook(args: argparse.Namespace) -> None:
    default = {"en": "pre-coding-playbook.md", "fr": "guide-pre-codage.md"}[args.lang]
    write_file(Path(args.output or default), render_playbook(args.lang), args.force)


def cmd_new_design(args: argparse.Namespace) -> None:
    opts = DesignOptions(
        title=args.title,
        size=args.size,
        author=args.author,
        acceptance_tests=args.acceptance_tests,
        modifies_existing=args.modifies_existing,
        lang=args.lang,
    )
    content = render_design_doc(opts)

    if opts.size == "small" and not args.output:
        # Small changes: print the note so it can be pasted into the PR description.
        print(content)
        return

    output = Path(args.output) if args.output else (
        Path(args.dir) / f"{date.today().isoformat()}-{slugify(opts.title)}.md"
    )
    write_file(output, content, args.force)


HELP_FORMATTER = argparse.RawDescriptionHelpFormatter

MAIN_DESCRIPTION = """\
Generate a "before writing code" playbook and design document skeletons.

The playbook walks through four phases (clarify -> explore -> design -> validate)
with a decision tree and checklists. The design document skeleton adapts its
sections to the size of the change and to what it touches.

Run `%(prog)s <command> -h` for the options of each command."""

MAIN_EPILOG = """\
examples:
  %(prog)s playbook                      # English playbook -> pre-coding-playbook.md
  %(prog)s playbook --lang fr            # French playbook  -> guide-pre-codage.md
  %(prog)s new-design "Add retry policy" --size medium
  %(prog)s new-design "Fix typo in error message" --size small      # printed to stdout
  %(prog)s new-design "Rewrite billing module" --size large \\
      --author Simon --acceptance-tests --modifies-existing"""

PLAYBOOK_DESCRIPTION = """\
Write the pre-coding playbook as markdown: a decision tree to follow before
coding, a table to size the design artifact, and a checklist for each step."""

PLAYBOOK_EPILOG = """\
examples:
  %(prog)s                                   # -> pre-coding-playbook.md
  %(prog)s --lang fr                         # -> guide-pre-codage.md
  %(prog)s -o docs/playbook.md --force       # custom path, overwrite if present"""

DESIGN_DESCRIPTION = """\
Write a design document skeleton for a feature or change.

Sections included depend on the options:
  always             context, examples, goals/non-goals, approach, testing plan,
                     PR breakdown, open questions
  --size medium      + alternatives considered, risks and rollback
  --size large       + observability, Mikado graph / prerequisites
  --modifies-existing  + existing behavior and characterization tests
  --acceptance-tests   + acceptance tests in the testing plan

Output:
  small              printed to stdout (paste it into the PR description),
                     unless -o is given
  medium / large     written to <dir>/<YYYY-MM-DD>-<title-slug>.md"""

DESIGN_EPILOG = """\
examples:
  %(prog)s "Add retry policy to the HTTP client"
  %(prog)s "Fix typo in error message" --size small | pbcopy
  %(prog)s "Politique de relance" --lang fr --size medium --modifies-existing
  %(prog)s "Rewrite billing module" --size large --author Simon \\
      --acceptance-tests --modifies-existing --dir docs/design"""


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="precoding.py",
        description=MAIN_DESCRIPTION,
        epilog=MAIN_EPILOG,
        formatter_class=HELP_FORMATTER,
    )
    sub = parser.add_subparsers(
        dest="command", metavar="<command>", title="commands"
    )

    # --- playbook ---------------------------------------------------------
    p = sub.add_parser(
        "playbook",
        help="Write the playbook (decision tree + checklists).",
        description=PLAYBOOK_DESCRIPTION,
        epilog=PLAYBOOK_EPILOG,
        formatter_class=HELP_FORMATTER,
    )
    p.add_argument(
        "--lang", choices=LANGS, default="en", metavar="{en,fr}",
        help="Language of the generated document (default: %(default)s).",
    )
    p.add_argument(
        "-o", "--output", metavar="PATH",
        help="Output file. Default: pre-coding-playbook.md (en) "
             "or guide-pre-codage.md (fr).",
    )
    p.add_argument(
        "--force", action="store_true",
        help="Overwrite the output file if it already exists.",
    )
    p.set_defaults(func=cmd_playbook)

    # --- new-design -------------------------------------------------------
    d = sub.add_parser(
        "new-design",
        help="Write a design document skeleton for a feature or change.",
        description=DESIGN_DESCRIPTION,
        epilog=DESIGN_EPILOG,
        formatter_class=HELP_FORMATTER,
    )
    d.add_argument(
        "title",
        help='Title of the feature or change (quote it, e.g. "Add retry policy").',
    )
    d.add_argument(
        "--lang", choices=LANGS, default="en", metavar="{en,fr}",
        help="Language of the generated document (default: %(default)s).",
    )
    d.add_argument(
        "--size", choices=["small", "medium", "large"], default="medium",
        help="Size / risk of the change; controls which sections are included "
             "(default: %(default)s). See the playbook's sizing table.",
    )
    d.add_argument(
        "--author", default="", metavar="NAME",
        help="Author name shown in the header (default: _TODO_).",
    )
    d.add_argument(
        "--acceptance-tests", action="store_true",
        help="The change needs verification beyond unit tests (end-to-end "
             "scenarios, performance, success criteria): add an acceptance "
             "tests section to the testing plan.",
    )
    d.add_argument(
        "--modifies-existing", action="store_true",
        help="The change modifies existing behavior: add a section for "
             "characterization tests.",
    )
    d.add_argument(
        "--dir", default="docs/design", metavar="DIR",
        help="Directory for medium/large documents (default: %(default)s).",
    )
    d.add_argument(
        "-o", "--output", metavar="PATH",
        help="Explicit output file (overrides --dir; also forces small "
             "documents to be written to a file).",
    )
    d.add_argument(
        "--force", action="store_true",
        help="Overwrite the output file if it already exists.",
    )
    d.set_defaults(func=cmd_new_design)

    return parser


def main() -> None:
    parser = build_parser()
    args = parser.parse_args()
    if not getattr(args, "func", None):
        # No command given: show the full help instead of an error.
        parser.print_help()
        sys.exit(1)
    args.func(args)


if __name__ == "__main__":
    main()
