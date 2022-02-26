
{{#:title}}<h1 class="title">{{:title}}</h1>{{/:title}}
{{#:author}}<h5>{{{:author}}}</h5>{{/:author}}
{{#:date}}<h5>{{{:date}}}</h5>{{/:date}}

{{{ :body }}}

<div class="footer">
  <p>
    Published from <a href="{{{:weave_source}}}">{{{:weave_source}}}</a>
    using <a href="http://github.com/JunoLab/Weave.jl">Weave.jl</a> {{:weave_version}} on {{:weave_date}}.
  </p>
</div>
