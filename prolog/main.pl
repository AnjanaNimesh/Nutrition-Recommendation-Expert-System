:- use_module(library(http/json)).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(readutil)).

project_file(RelPath, AbsPath) :-
    source_file(project_file(_, _), MainFile),
    file_directory_name(MainFile, PrologDir),
    file_directory_name(PrologDir, Root),
    atomic_list_concat([Root, '/', RelPath], Candidate),
    absolute_file_name(Candidate, AbsPath).

load_knowledge_base :-
    project_file('prolog/knowledge_base.pl', KBPath),
    consult(KBPath).

:- load_knowledge_base.

server_port(8080).

send_json_response(Result) :-
    atom_json_dict(Json, Result, [serialize_unknown(true)]),
    format('Content-type: application/json~nAccess-Control-Allow-Origin: *~nAccess-Control-Allow-Headers: Content-Type~nAccess-Control-Allow-Methods: POST, OPTIONS~n~n'),
    write(Json), nl.

reply_options(_Request) :-
    format('Content-type: application/json~nAccess-Control-Allow-Origin: *~nAccess-Control-Allow-Headers: Content-Type~nAccess-Control-Allow-Methods: POST, OPTIONS~n~n'),
    write('{"status":"ok"}'), nl.

serve_static_file(File, _Request) :-
    exists_file(File),
    file_name_extension(_, Extension, File),
    static_content_type(Extension, ContentType),
    read_file_to_string(File, Contents, []),
    format('Content-type: ~w; charset=UTF-8~n~n', [ContentType]),
    format('~s', [Contents]),
    !.

static_content_type(html, 'text/html').
static_content_type(css, 'text/css').
static_content_type(js, 'application/javascript').

file_in_project(RelPath, AbsPath) :-
    project_file(RelPath, AbsPath).

serve_root(Request) :-
    file_in_project('web/index.html', File),
    serve_static_file(File, Request).

serve_css(Request) :-
    file_in_project('web/style.css', File),
    serve_static_file(File, Request).

serve_js(Request) :-
    file_in_project('web/script.js', File),
    serve_static_file(File, Request).

handle_post_recommend(Request) :-
    (   catch(http_read_json_dict(Request, Data), _Error, fail)
    ->  (   build_user_profile(Data, Profile)
        ->  (   generate_recommendation(Profile, Result)
            ->  send_json_response(Result)
            ;   send_json_response(_{error: 'Recommendation generation failed.'})
            )
        ;   send_json_response(_{error: 'The submitted profile is missing required fields.'})
        )
    ;   send_json_response(_{error: 'The request body is not valid JSON.'})
    ).

handle_recommend(Request) :-
    memberchk(method(post), Request),
    !,
    handle_post_recommend(Request).
handle_recommend(Request) :-
    memberchk(method(options), Request),
    reply_options(Request).

:- http_handler('/', serve_root, []).
:- http_handler('/style.css', serve_css, []).
:- http_handler('/script.js', serve_js, []).
:- http_handler('/recommend', handle_recommend, [methods([post, options])]).

start_server :-
    server_port(Port),
    catch(
        http_server(http_dispatch, [port(Port)]),
        error(permission_error(create, thread, 'http@8080'), _),
        format('Server already running on http://localhost:~w/~n', [Port])
    ),
    format('Nutrition expert system running at http://localhost:~w/~n', [Port]).

:- initialization(start_server).
